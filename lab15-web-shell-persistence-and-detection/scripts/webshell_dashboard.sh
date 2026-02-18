#!/bin/bash

WEB_ROOT="/var/www/html"
ACCESS_LOG="/var/log/apache2/access.log"
ALERT_LOG="$HOME/webshell_alerts.log"

display_dashboard() {

 clear
 echo "========================================"
 echo "        Web Shell Monitoring Dashboard"
 echo "========================================"
 echo "Current Time: $(date)"
 echo

 echo "[1] Total PHP Files:"
 find "$WEB_ROOT" -name "*.php" | wc -l

 echo
 echo "[2] Suspicious Function Occurrences:"
 grep -rE "(system|exec|eval|base64_decode)" "$WEB_ROOT" | wc -l

 echo
 echo "[3] Total Web Requests:"
 wc -l < "$ACCESS_LOG"

 echo
 echo "[4] Top 5 Active IPs:"
 awk '{print $1}' "$ACCESS_LOG" | sort | uniq -c | sort -nr | head -5

 echo
 echo "[5] Recent Alerts:"
 if [ -f "$ALERT_LOG" ]; then
     tail -5 "$ALERT_LOG"
 else
     echo "No alerts yet."
 fi

 echo
 echo "========================================"
}

display_dashboard
