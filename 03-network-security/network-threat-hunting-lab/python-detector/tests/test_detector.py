import tempfile
import unittest
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
PROJECT = HERE.parent
sys.path.insert(0, str(PROJECT))

from detect_recon import WindowBucket, build_alert, event_window_start, load_config
from scoring import calculate_risk, risk_level


class DetectorTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.config = load_config(PROJECT / "config.yaml")

    def test_window_flooring(self):
        self.assertEqual(event_window_start(61.9, 30), 60.0)

    def test_risk_levels(self):
        self.assertEqual(risk_level(0), "Low")
        self.assertEqual(risk_level(30), "Medium")
        self.assertEqual(risk_level(60), "High")
        self.assertEqual(risk_level(80), "Critical")

    def test_port_scan_score(self):
        metrics = {
            "unique_destination_ports": 100,
            "unique_destination_hosts": 1,
            "failed_connections": 200,
            "admin_service_attempts": 2,
            "unique_http_uris": 0,
        }
        result = calculate_risk(metrics, self.config)
        self.assertEqual(result.score, 50)
        self.assertEqual(result.level, "Medium")
        self.assertEqual(result.classification, "probable_port_scan")
        self.assertIn("high_unique_port_count", result.signals)
        self.assertIn("high_failed_connection_count", result.signals)

    def test_baseline_score(self):
        metrics = {
            "unique_destination_ports": 1,
            "unique_destination_hosts": 1,
            "failed_connections": 0,
            "admin_service_attempts": 0,
            "unique_http_uris": 3,
        }
        result = calculate_risk(metrics, self.config)
        self.assertEqual(result.score, 0)
        self.assertEqual(result.classification, "baseline_or_low_activity")

    def test_alert_shape(self):
        bucket = WindowBucket(
            source_ip="192.168.10.10",
            start_ts=1785210810.0,
            end_ts=1785210840.0,
            destination_ports=set(range(1, 101)),
            destination_hosts={"192.168.20.10"},
            failed_connections=200,
            admin_service_attempts=2,
            evidence_sources={"zeek_conn_log"},
        )
        alert = build_alert(bucket, self.config)
        self.assertEqual(alert["event_type"], "network_reconnaissance")
        self.assertEqual(alert["unique_destination_ports"], 100)
        self.assertEqual(alert["risk_score"], 50)

    def test_invalid_window_rejected(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            config_path = Path(temp_dir) / "bad.yaml"
            config_path.write_text(
                "window_seconds: 0\n"
                "minimum_alert_score: 30\n"
                "thresholds: {}\n"
                "admin_ports: []\n"
                "failed_connection_states: []\n"
                "risk_weights: {}\n",
                encoding="utf-8",
            )
            with self.assertRaises(ValueError):
                load_config(config_path)


if __name__ == "__main__":
    unittest.main()
