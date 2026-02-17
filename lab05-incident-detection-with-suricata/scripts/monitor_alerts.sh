#!/bin/bash

LOG_FILE="/var/log/suricata/eve.json"

echo "Starting real-time Suricata alert monitoring..."
echo "Press Ctrl+C to stop"
echo

sudo tail -f $LOG_FILE | while read line; do
  if echo "$line" | jq -e 'select(.event_type=="alert")' > /dev/null 2>&1; then
    TIMESTAMP=$(echo "$line" | jq -r '.timestamp')
    SIGNATURE=$(echo "$line" | jq -r '.alert.signature')
    SRC_IP=$(echo "$line" | jq -r '.src_ip')
    DEST_IP=$(echo "$line" | jq -r '.dest_ip')
    SEVERITY=$(echo "$line" | jq -r '.alert.severity')

    echo "ALERT: [$TIMESTAMP] $SIGNATURE"
    echo " Source: $SRC_IP -> Destination: $DEST_IP"
    echo " Severity: $SEVERITY"
    echo " ---"
  fi
done
