#!/bin/bash

LOG_FILE="/var/log/suricata/eve.json"

echo "=== Suricata Rule Performance Analysis ==="
echo "Analysis Date: $(date)"
echo

echo "Rule Hit Statistics (Top 20):"
sudo cat $LOG_FILE | jq -r 'select(.event_type=="alert") | "\(.alert.gid):\(.alert.signature_id) - \(.alert.signature)"' | sort | uniq -c | sort -nr | head -20

echo
echo "Custom Rule Performance:"
sudo cat $LOG_FILE | jq -r 'select(.event_type=="alert" and (.alert.signature_id >= 1000000)) | "\(.alert.signature_id) - \(.alert.signature)"' | sort | uniq -c | sort -nr

echo
TOTAL_ALERTS=$(sudo cat $LOG_FILE | jq -s 'map(select(.event_type=="alert")) | length')
CUSTOM_ALERTS=$(sudo cat $LOG_FILE | jq -s 'map(select(.event_type=="alert" and (.alert.signature_id >= 1000000))) | length')

echo "Total Alerts: $TOTAL_ALERTS"
echo "Custom Rule Alerts: $CUSTOM_ALERTS"

if [ "$TOTAL_ALERTS" -gt 0 ]; then
  PERCENTAGE=$(echo "scale=2; $CUSTOM_ALERTS * 100 / $TOTAL_ALERTS" | bc -l 2>/dev/null || echo "N/A")
  echo "Custom Rule Coverage: $PERCENTAGE%"
fi
