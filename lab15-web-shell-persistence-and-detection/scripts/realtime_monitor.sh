#!/bin/bash

ACCESS_LOG="/var/log/apache2/access.log"
ALERT_LOG="$HOME/webshell_alerts.log"
WEB_ROOT="/var/www/html"

echo "Starting Real-Time Web Shell Monitor..."
echo "Alerts will be written to $ALERT_LOG"

monitor_logs() {

 tail -F "$ACCESS_LOG" | while read line; do

     if echo "$line" | grep -qE "(cmd=|exec=|x=|base64)"; then

         IP=$(echo "$line" | awk '{print $1}')
         TIMESTAMP=$(date)

         ALERT="[ALERT] $TIMESTAMP - Suspicious request from $IP"

         echo "$ALERT"
         echo "$ALERT" >> "$ALERT_LOG"
     fi
 done
}

monitor_filesystem() {

 echo "Monitoring file changes in $WEB_ROOT..."

 inotifywait -m -r -e create -e modify "$WEB_ROOT" --format "%w%f" | while read file; do

     if [[ "$file" == *.php ]]; then
         ALERT="[ALERT] $(date) - PHP file created/modified: $file"
         echo "$ALERT"
         echo "$ALERT" >> "$ALERT_LOG"
     fi
 done
}

monitor_logs &
monitor_filesystem
