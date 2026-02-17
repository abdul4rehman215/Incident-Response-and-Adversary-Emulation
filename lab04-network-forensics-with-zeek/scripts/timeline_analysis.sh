#!/bin/bash

echo "NETWORK TIMELINE ANALYSIS"
echo "========================="

OUTPUT="network_timeline.txt"
> "$OUTPUT"

if [ -f malicious_activity.log ]; then
    while IFS=',' read -r timestamp source alert_type details; do
        echo "$timestamp [ALERT] $source - $alert_type $details" >> "$OUTPUT"
    done < malicious_activity.log
fi

if [ -f conn.log ]; then
    grep '^{' conn.log | head -20 | while read -r line; do
        ts=$(echo "$line" | jq -r '.ts' 2>/dev/null)
        orig=$(echo "$line" | jq -r '."id.orig_h"' 2>/dev/null)
        resp=$(echo "$line" | jq -r '."id.resp_h"' 2>/dev/null)
        port=$(echo "$line" | jq -r '."id.resp_p"' 2>/dev/null)

        if [ "$ts" != "null" ]; then
            readable=$(date -d "@$ts" "+%Y-%m-%d %H:%M:%S" 2>/dev/null)
            echo "$readable [CONN] $orig -> $resp:$port" >> "$OUTPUT"
        fi
    done
fi

sort "$OUTPUT" -o "$OUTPUT"

echo "Timeline created: $OUTPUT"
tail -20 "$OUTPUT"
