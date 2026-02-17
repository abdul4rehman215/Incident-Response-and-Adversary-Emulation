#!/bin/bash

LOG_DEST="$HOME/incident_response/logs"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')

mkdir -p "$LOG_DEST/system"
mkdir -p "$LOG_DEST/network"
mkdir -p "$LOG_DEST/application"

echo "Collecting system logs for incident analysis..."

sudo cp /var/log/syslog "$LOG_DEST/system/syslog_$DATE.log" 2>/dev/null || echo "Syslog not accessible"
sudo cp /var/log/auth.log "$LOG_DEST/system/auth_$DATE.log" 2>/dev/null || echo "Auth log not accessible"
sudo cp /var/log/kern.log "$LOG_DEST/system/kern_$DATE.log" 2>/dev/null || echo "Kernel log not accessible"

sudo dmesg | grep -i network > "$LOG_DEST/network/dmesg_network_$DATE.log"

sudo find /var/log -type f -name "*.log" -exec basename {} \; > "$LOG_DEST/application/available_logs_$DATE.txt"

echo "Log collection completed. Files saved with timestamp: $DATE"
