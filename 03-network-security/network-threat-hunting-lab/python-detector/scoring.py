from __future__ import annotations

from dataclasses import dataclass
from typing import Any


@dataclass(frozen=True)
class RiskResult:
    score: int
    level: str
    classification: str
    signals: list[str]


def risk_level(score: int) -> str:
    if score >= 80:
        return "Critical"
    if score >= 60:
        return "High"
    if score >= 30:
        return "Medium"
    return "Low"


def classify(
    metrics: dict[str, int],
    thresholds: dict[str, int],
) -> str:
    """
    Select the primary classification using the required priority order.
    """

    if metrics["unique_http_uris"] >= thresholds["unique_http_uris"]:
        return "probable_http_enumeration"

    if (
        metrics["unique_destination_hosts"]
        >= thresholds["unique_hosts"]
    ):
        return "probable_host_discovery"

    if (
        metrics["unique_destination_ports"]
        >= thresholds["unique_ports_high"]
    ):
        return "probable_port_scan"

    if (
        metrics["admin_service_attempts"]
        >= thresholds["admin_port_attempts"]
    ):
        return "probable_admin_service_probing"

    if (
        metrics["failed_connections"]
        >= thresholds["failed_connections"]
    ):
        return "probable_failed_connection_burst"

    return "baseline_or_low_activity"


def calculate_risk(
    metrics: dict[str, int],
    config: dict[str, Any],
) -> RiskResult:
    thresholds = config["thresholds"]
    weights = config["risk_weights"]

    score = 0
    signals: list[str] = []

    unique_ports = metrics["unique_destination_ports"]

    if unique_ports >= thresholds["unique_ports_high"]:
        score += weights["unique_ports_high"]
        signals.append("high_unique_port_count")
    elif unique_ports >= thresholds["unique_ports_medium"]:
        score += weights["unique_ports_medium"]
        signals.append("elevated_unique_port_count")

    if (
        metrics["unique_destination_hosts"]
        >= thresholds["unique_hosts"]
    ):
        score += weights["unique_hosts"]
        signals.append("multi_host_discovery")

    if (
        metrics["failed_connections"]
        >= thresholds["failed_connections"]
    ):
        score += weights["failed_connections"]
        signals.append("high_failed_connection_count")

    if (
        metrics["admin_service_attempts"]
        >= thresholds["admin_port_attempts"]
    ):
        score += weights["admin_service_probing"]
        signals.append("administrative_service_probing")

    if metrics["unique_http_uris"] >= thresholds["unique_http_uris"]:
        score += weights["http_enumeration"]
        signals.append("http_path_enumeration")

    score = min(score, 100)

    return RiskResult(
        score=score,
        level=risk_level(score),
        classification=classify(metrics, thresholds),
        signals=signals,
    )
