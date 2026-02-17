#!/bin/bash

LOG_FILE="/var/log/suricata/eve.json"

echo "=== Suricata Log Analysis Report ==="
echo "Generated on: $(date)"
echo

if [ ! -f "$LOG_FILE" ]; then
  echo "Error: Suricata log file not found at $LOG_FILE"
  exit 1
fi

echo "Total Events: $(wc -l < $LOG_FILE)"

echo
echo "=== Alert Summary ==="
sudo cat $LOG_FILE | jq -r 'select(.event_type=="alert") | .alert.signature' | sort | uniq -c | sort -nr

echo
echo "=== Top Source IPs ==="
sudo cat $LOG_FILE | jq -r 'select(.event_type=="alert") | .src_ip' | sort | uniq -c | sort -nr | head -10

echo
echo "=== Alert Severity ==="
sudo cat $LOG_FILE | jq -r 'select(.event_type=="alert") | .alert.severity' | sort | uniq -c

echo
echo "=== Recent Alerts ==="
sudo tail -10 $LOG_FILE | jq -r 'select(.event_type=="alert") | "\(.timestamp) - \(.alert.signature) - \(.src_ip):\(.src_port) -> \(.dest_ip):\(.dest_port)"'

echo
echo "=== Analysis Complete ==="
