#!/bin/bash

LOG_FILE="$HOME/incident_response/logs/system/alerts.log"

mkdir -p "$HOME/incident_response/logs/system"

while true; do

    HIGH_CPU=$(ps aux --sort=-%cpu | awk 'NR==2 {print $3}')

    if (( $(echo "$HIGH_CPU > 80" | bc -l) )); then
        echo "$(date): High CPU usage detected: $HIGH_CPU%" >> "$LOG_FILE"
    fi

    if ls /tmp/*suspicious* /tmp/*malware* 2>/dev/null; then
        echo "$(date): Suspicious files detected in /tmp" >> "$LOG_FILE"
    fi

    sleep 60

done
