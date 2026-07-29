from __future__ import annotations

import json
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Iterator


@dataclass(frozen=True)
class NormalizedEvent:
    """Normalized representation of one Zeek event."""

    ts: float
    source_ip: str
    destination_ip: str | None
    destination_port: int | None
    conn_state: str | None
    uri: str | None
    event_source: str


def _warning(message: str) -> None:
    print(f"[WARNING] {message}", file=sys.stderr)


def _read_json_lines(path: Path) -> Iterator[tuple[int, dict[str, Any]]]:
    """Read JSON Lines while skipping empty, invalid, or non-object lines."""

    with path.open("r", encoding="utf-8", errors="replace") as handle:
        for line_number, raw_line in enumerate(handle, start=1):
            line = raw_line.strip()

            if not line:
                continue

            try:
                record = json.loads(line)
            except json.JSONDecodeError as exc:
                _warning(
                    f"Skipping invalid JSON in {path} line {line_number}: "
                    f"{exc.msg}"
                )
                continue

            if not isinstance(record, dict):
                _warning(
                    f"Skipping non-object JSON in {path} line {line_number}"
                )
                continue

            yield line_number, record


def _to_float(value: Any) -> float | None:
    try:
        return float(value)
    except (TypeError, ValueError):
        return None


def _to_int(value: Any) -> int | None:
    if value is None:
        return None

    try:
        return int(value)
    except (TypeError, ValueError):
        return None


def parse_conn_log(path: Path) -> Iterator[NormalizedEvent]:
    """Parse Zeek JSON conn.log events."""

    for line_number, record in _read_json_lines(path):
        ts = _to_float(record.get("ts"))
        source_ip = record.get("id.orig_h")

        if ts is None:
            _warning(f"Skipping {path} line {line_number}: invalid ts")
            continue

        if not isinstance(source_ip, str) or not source_ip:
            _warning(
                f"Skipping {path} line {line_number}: missing source IP"
            )
            continue

        destination_ip = record.get("id.resp_h")
        if not isinstance(destination_ip, str):
            destination_ip = None

        conn_state = record.get("conn_state")
        if not isinstance(conn_state, str):
            conn_state = None

        yield NormalizedEvent(
            ts=ts,
            source_ip=source_ip,
            destination_ip=destination_ip,
            destination_port=_to_int(record.get("id.resp_p")),
            conn_state=conn_state,
            uri=None,
            event_source="zeek_conn_log",
        )


def parse_http_log(path: Path) -> Iterator[NormalizedEvent]:
    """Parse Zeek JSON http.log events."""

    for line_number, record in _read_json_lines(path):
        ts = _to_float(record.get("ts"))
        source_ip = record.get("id.orig_h")

        if ts is None:
            _warning(f"Skipping {path} line {line_number}: invalid ts")
            continue

        if not isinstance(source_ip, str) or not source_ip:
            _warning(
                f"Skipping {path} line {line_number}: missing source IP"
            )
            continue

        destination_ip = record.get("id.resp_h")
        if not isinstance(destination_ip, str):
            destination_ip = None

        uri = record.get("uri")
        if not isinstance(uri, str) or not uri:
            uri = None

        yield NormalizedEvent(
            ts=ts,
            source_ip=source_ip,
            destination_ip=destination_ip,
            destination_port=_to_int(record.get("id.resp_p")),
            conn_state=None,
            uri=uri,
            event_source="zeek_http_log",
        )
