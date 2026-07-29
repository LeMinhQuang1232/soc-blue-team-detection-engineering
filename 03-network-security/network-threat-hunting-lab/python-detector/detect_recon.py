#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import sys
from dataclasses import dataclass, field
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

import yaml

from parsers import NormalizedEvent, parse_conn_log, parse_http_log
from scoring import calculate_risk


@dataclass
class WindowBucket:
    source_ip: str
    start_ts: float
    end_ts: float
    destination_ports: set[int] = field(default_factory=set)
    destination_hosts: set[str] = field(default_factory=set)
    http_uris: set[str] = field(default_factory=set)
    failed_connections: int = 0
    admin_service_attempts: int = 0
    evidence_sources: set[str] = field(default_factory=set)


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Detect reconnaissance behavior from Zeek JSON conn.log "
            "and http.log files."
        )
    )

    parser.add_argument(
        "--conn",
        required=True,
        type=Path,
        help="Path to Zeek JSON conn.log",
    )

    parser.add_argument(
        "--http",
        type=Path,
        help="Optional path to Zeek JSON http.log",
    )

    parser.add_argument(
        "--config",
        required=True,
        type=Path,
        help="Path to detector YAML configuration",
    )

    parser.add_argument(
        "--output",
        required=True,
        type=Path,
        help="Output JSON Lines file",
    )

    parser.add_argument(
        "--emit-all",
        action="store_true",
        help=(
            "Write all windows, including Low windows below the "
            "minimum alert score."
        ),
    )

    return parser.parse_args()


def load_config(path: Path) -> dict[str, Any]:
    if not path.is_file():
        raise FileNotFoundError(f"Config file not found: {path}")

    with path.open("r", encoding="utf-8") as handle:
        config = yaml.safe_load(handle)

    if not isinstance(config, dict):
        raise ValueError("Configuration root must be a YAML object")

    required_sections = {
        "window_seconds",
        "minimum_alert_score",
        "thresholds",
        "admin_ports",
        "failed_connection_states",
        "risk_weights",
    }

    missing = required_sections.difference(config)
    if missing:
        raise ValueError(
            f"Missing configuration keys: {', '.join(sorted(missing))}"
        )

    window_seconds = int(config["window_seconds"])
    if window_seconds <= 0:
        raise ValueError("window_seconds must be greater than zero")

    config["window_seconds"] = window_seconds
    config["minimum_alert_score"] = int(
        config["minimum_alert_score"]
    )
    config["admin_ports"] = {
        int(port) for port in config["admin_ports"]
    }
    config["failed_connection_states"] = {
        str(state) for state in config["failed_connection_states"]
    }

    return config


def event_window_start(ts: float, window_seconds: int) -> float:
    return float(int(ts // window_seconds) * window_seconds)


def add_event(
    buckets: dict[tuple[str, int], WindowBucket],
    event: NormalizedEvent,
    config: dict[str, Any],
) -> None:
    window_seconds = config["window_seconds"]
    start_ts = event_window_start(event.ts, window_seconds)
    window_id = int(start_ts // window_seconds)
    key = (event.source_ip, window_id)

    if key not in buckets:
        buckets[key] = WindowBucket(
            source_ip=event.source_ip,
            start_ts=start_ts,
            end_ts=start_ts + window_seconds,
        )

    bucket = buckets[key]
    bucket.evidence_sources.add(event.event_source)

    if event.destination_ip:
        bucket.destination_hosts.add(event.destination_ip)

    if event.destination_port is not None:
        bucket.destination_ports.add(event.destination_port)

    if event.event_source == "zeek_conn_log":
        if event.conn_state in config["failed_connection_states"]:
            bucket.failed_connections += 1

        if event.destination_port in config["admin_ports"]:
            bucket.admin_service_attempts += 1

    if event.event_source == "zeek_http_log" and event.uri:
        bucket.http_uris.add(event.uri)


def iso_timestamp(ts: float) -> str:
    """
    Convert Unix time to an ISO-8601 timestamp using the system timezone.

    On this lab host, the timezone should be Asia/Ho_Chi_Minh.
    """

    return (
        datetime.fromtimestamp(ts, tz=timezone.utc)
        .astimezone()
        .isoformat()
    )


def evidence_source_name(sources: set[str]) -> str:
    if sources == {"zeek_conn_log"}:
        return "zeek_conn_log"

    if sources == {"zeek_http_log"}:
        return "zeek_http_log"

    return "zeek_conn_and_http_logs"


def build_alert(
    bucket: WindowBucket,
    config: dict[str, Any],
) -> dict[str, Any]:
    metrics = {
        "unique_destination_ports": len(bucket.destination_ports),
        "unique_destination_hosts": len(bucket.destination_hosts),
        "failed_connections": bucket.failed_connections,
        "admin_service_attempts": bucket.admin_service_attempts,
        "unique_http_uris": len(bucket.http_uris),
    }

    risk = calculate_risk(metrics, config)

    return {
        "event_type": "network_reconnaissance",
        "source_ip": bucket.source_ip,
        "window_start": iso_timestamp(bucket.start_ts),
        "window_end": iso_timestamp(bucket.end_ts),
        "unique_destination_ports": metrics[
            "unique_destination_ports"
        ],
        "unique_destination_hosts": metrics[
            "unique_destination_hosts"
        ],
        "failed_connections": metrics["failed_connections"],
        "admin_service_attempts": metrics[
            "admin_service_attempts"
        ],
        "unique_http_uris": metrics["unique_http_uris"],
        "time_window_seconds": config["window_seconds"],
        "risk_score": risk.score,
        "risk_level": risk.level,
        "classification": risk.classification,
        "signals": risk.signals,
        "evidence_source": evidence_source_name(
            bucket.evidence_sources
        ),
    }


def main() -> int:
    args = parse_arguments()

    try:
        config = load_config(args.config)
    except (OSError, ValueError, yaml.YAMLError) as exc:
        print(f"[ERROR] Failed to load config: {exc}", file=sys.stderr)
        return 1

    if not args.conn.is_file():
        print(
            f"[ERROR] conn.log not found: {args.conn}",
            file=sys.stderr,
        )
        return 1

    if args.http is not None and not args.http.is_file():
        print(
            f"[ERROR] http.log not found: {args.http}",
            file=sys.stderr,
        )
        return 1

    buckets: dict[tuple[str, int], WindowBucket] = {}

    for event in parse_conn_log(args.conn):
        add_event(buckets, event, config)

    if args.http is not None:
        for event in parse_http_log(args.http):
            add_event(buckets, event, config)

    alerts: list[dict[str, Any]] = []

    ordered_buckets = sorted(
        buckets.values(),
        key=lambda bucket: (bucket.start_ts, bucket.source_ip),
    )

    for bucket in ordered_buckets:
        alert = build_alert(bucket, config)

        if (
            args.emit_all
            or alert["risk_score"]
            >= config["minimum_alert_score"]
        ):
            alerts.append(alert)

    args.output.parent.mkdir(parents=True, exist_ok=True)

    with args.output.open("w", encoding="utf-8") as handle:
        for alert in alerts:
            handle.write(
                json.dumps(
                    alert,
                    ensure_ascii=False,
                    separators=(",", ":"),
                )
            )
            handle.write("\n")

    print(f"[INFO] Windows processed: {len(buckets)}")
    print(f"[INFO] Alerts written: {len(alerts)}")
    print(f"[INFO] Output: {args.output}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
