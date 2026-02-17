#!/bin/bash

LOG_FILE="/var/log/suricata/eve.json"

show_dashboard() {
    clear
    echo
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                 SURICATA ALERT DASHBOARD                    ║"
    echo "╠══════════════════════════════════════════════════════════════╣"
    echo "║ Last Updated: $(date)                                        ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo

    TODAY=$(date +%Y-%m-%d)
    TOTAL_TODAY=$(sudo grep "$TODAY" $LOG_FILE 2>/dev/null | jq -s 'map(select(.event_type=="alert")) | length' 2>/dev/null || echo "0")

    echo " Alerts Today: $TOTAL_TODAY"
    echo

    echo " Recent Alerts:"
    echo "─────────────────────────────────────────────────────────────"
    sudo tail -20 $LOG_FILE | jq -r 'select(.event_type=="alert") | "\(.timestamp[11:19]) | \(.alert.signature) | \(.src_ip)"' 2>/dev/null | tail -5
    echo

    echo " Top Threats (Last 100 alerts):"
    echo "─────────────────────────────────────────────────────────────"
    sudo tail -100 $LOG_FILE | jq -r 'select(.event_type=="alert") | .alert.signature' 2>/dev/null | sort | uniq -c | sort -nr | head -5
    echo

    echo " System Status:"
    echo "─────────────────────────────────────────────────────────────"
    if pgrep suricata > /dev/null; then
        echo " Suricata: Running"
    else
        echo " Suricata: Stopped"
    fi

    DISK_USAGE=$(df /var/log | tail -1 | awk '{print $5}')
    echo " Log Disk Usage: $DISK_USAGE"
    echo
    echo "Press Ctrl+C to exit, or wait 30 seconds for refresh..."
}

while true; do
    show_dashboard
    sleep 30
done
