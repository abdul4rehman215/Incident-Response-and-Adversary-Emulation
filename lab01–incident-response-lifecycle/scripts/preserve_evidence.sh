#!/bin/bash

DATE=$(date '+%Y-%m-%d_%H-%M-%S')
EVIDENCE_DIR="$HOME/incident_response/evidence/volatile"

mkdir -p "$EVIDENCE_DIR"

echo "Preserving volatile evidence..."

ps aux > "$EVIDENCE_DIR/processes_$DATE.txt"
ss -tuln > "$EVIDENCE_DIR/network_connections_$DATE.txt"
lsof > "$EVIDENCE_DIR/open_files_$DATE.txt"
who > "$EVIDENCE_DIR/logged_users_$DATE.txt"
mount > "$EVIDENCE_DIR/mounted_filesystems_$DATE.txt"
cat /proc/meminfo > "$EVIDENCE_DIR/memory_info_$DATE.txt"
cat /proc/cpuinfo > "$EVIDENCE_DIR/cpu_info_$DATE.txt"
ip addr > "$EVIDENCE_DIR/network_config_$DATE.txt"
ip route > "$EVIDENCE_DIR/routing_table_$DATE.txt"
uname -a > "$EVIDENCE_DIR/system_info_$DATE.txt"
uptime > "$EVIDENCE_DIR/uptime_$DATE.txt"
date > "$EVIDENCE_DIR/timestamp_$DATE.txt"

echo "Volatile evidence preserved with timestamp: $DATE"
