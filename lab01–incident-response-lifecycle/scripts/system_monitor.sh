#!/bin/bash

LOG_DIR="$HOME/incident_response/logs/system"
DATE=$(date '+%Y-%m-%d_%H-%M-%S')

mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/monitor_$DATE.log"

echo "=== System Monitoring Report - $DATE ===" > "$LOG_FILE"

echo "--- CPU and Memory Usage ---" >> "$LOG_FILE"
top -bn1 | head -20 >> "$LOG_FILE"

echo "--- Active Network Connections ---" >> "$LOG_FILE"
ss -tuln >> "$LOG_FILE"

echo "--- Running Processes ---" >> "$LOG_FILE"
ps aux --sort=-%cpu | head -20 >> "$LOG_FILE"

echo "--- Disk Usage ---" >> "$LOG_FILE"
df -h >> "$LOG_FILE"

echo "--- Recent Login Attempts ---" >> "$LOG_FILE"
last -10 >> "$LOG_FILE"

echo "Monitoring report saved to: $LOG_FILE"
