#!/bin/bash

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_DIR="system_analysis_$TIMESTAMP"

mkdir -p "$OUTPUT_DIR"

echo "=== Starting System Information Collection ==="

collect_system_info() {
{
echo "=== SYSTEM INFORMATION ==="
echo "Hostname: $(hostname)"
echo "Kernel Version: $(uname -r)"
echo "OS Release:"
cat /etc/os-release
echo ""
echo "System Uptime:"
uptime
echo ""
echo "Current Date:"
date
} > "$OUTPUT_DIR/system_info.txt"
}

collect_user_info() {
{
echo "=== USER INFORMATION ==="
echo "Currently Logged In Users:"
who
echo ""
echo "Last 20 Login Records:"
last -n 20
echo ""
echo "Failed Login Attempts:"
sudo lastb -n 20 2>/dev/null
echo ""
echo "All System Users:"
cut -d: -f1 /etc/passwd
} > "$OUTPUT_DIR/user_info.txt"
}

collect_process_info() {
{
echo "=== PROCESS INFORMATION ==="
echo "All Running Processes Sorted by CPU:"
ps aux --sort=-%cpu
echo ""
echo "Process Tree:"
pstree -p
echo ""
echo "Top CPU Consuming Processes:"
ps aux --sort=-%cpu | head -10
} > "$OUTPUT_DIR/process_info.txt"
}

collect_network_info() {
{
echo "=== NETWORK INFORMATION ==="
echo "Network Interfaces:"
ip a
echo ""
echo "Routing Table:"
ip route
echo ""
echo "Active Connections:"
ss -tunap
echo ""
echo "Listening Services:"
ss -tulnp
} > "$OUTPUT_DIR/network_info.txt"
}

collect_filesystem_info() {
{
echo "=== FILESYSTEM INFORMATION ==="
echo "Mounted Filesystems:"
mount
echo ""
echo "Disk Usage:"
df -h
echo ""
echo "Recently Modified Files in /var/log (Last 24 Hours):"
find /var/log -type f -mtime -1
} > "$OUTPUT_DIR/filesystem_info.txt"
}

collect_system_info
collect_user_info
collect_process_info
collect_network_info
collect_filesystem_info

echo "System information collection completed!"
echo "Results saved in: $OUTPUT_DIR"
