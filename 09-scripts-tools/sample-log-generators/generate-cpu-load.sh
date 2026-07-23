#!/usr/bin/env bash
set -euo pipefail

DURATION="${1:-120}"

if ! command -v stress-ng >/dev/null 2>&1; then
  echo "stress-ng is not installed." >&2
  exit 1
fi

# Controlled lab test. Stops automatically after DURATION seconds.
stress-ng --cpu 0 --timeout "${DURATION}s" --metrics-brief
