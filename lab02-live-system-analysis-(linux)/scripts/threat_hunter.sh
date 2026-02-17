#!/bin/bash

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_DIR="threat_hunting_$TIMESTAMP"

mkdir -p "$OUTPUT_DIR"

echo "=== Advanced Threat Hunting Analysis ==="

hunt_persistence() {
{
echo "=== PERSISTENCE MECHANISM ANALYSIS ==="

echo "System Cron Jobs:"
cat /etc/crontab 2>/dev/null
ls -la /etc/cron.*

echo ""
echo "User Cron Jobs:"
for user in $(cut -f1 -d: /etc/passwd); do
    crontab -u "$user" -l 2>/dev/null
done

echo ""
echo "Enabled Systemd Services:"
systemctl list-unit-files --type=service --state=enabled

echo ""
echo "Startup Scripts in /etc/init.d/:"
ls -la /etc/init.d/

echo ""
echo "User Profile Files:"
ls -la ~/.bashrc ~/.profile 2>/dev/null

} > "$OUTPUT_DIR/persistence_analysis.txt"
}

hunt_process_anomalies() {
{
echo "=== PROCESS ANOMALY ANALYSIS ==="

echo "Orphan Processes (PPID = 1):"
ps -eo pid,ppid,cmd | awk '$2==1 {print}'

echo ""
echo "Processes Running from /tmp or /var/tmp:"
ps aux | grep -E "/tmp|/var/tmp" | grep -v grep

echo ""
echo "High CPU Processes:"
ps aux --sort=-%cpu | head -10

echo ""
echo "High Memory Processes:"
ps aux --sort=-%mem | head -10

echo ""
echo "Network Related Processes:"
ss -tunap

} > "$OUTPUT_DIR/process_anomalies.txt"
}

hunt_suspicious_files() {
{
echo "=== SUSPICIOUS FILE ANALYSIS ==="

echo "SUID Files:"
find / -perm -4000 -type f 2>/dev/null

echo ""
echo "SGID Files:"
find / -perm -2000 -type f 2>/dev/null

echo ""
echo "World-Writable Files:"
find / -type f -perm -0002 2>/dev/null

echo ""
echo "Recently Modified System Files (Last 24 Hours):"
find /etc -type f -mtime -1 2>/dev/null

echo ""
echo "Hidden Files in /tmp:"
find /tmp -type f -name ".*" 2>/dev/null

} > "$OUTPUT_DIR/suspicious_files.txt"
}

hunt_network_indicators() {
{
echo "=== NETWORK INDICATOR ANALYSIS ==="

echo "Listening Ports:"
ss -tulnp

echo ""
echo "External Connections:"
ss -tunap | grep -v "127.0.0.1"

echo ""
echo "DNS Configuration:"
cat /etc/resolv.conf 2>/dev/null

echo ""
echo "Firewall Rules (nftables):"
sudo nft list ruleset 2>/dev/null

} > "$OUTPUT_DIR/network_indicators.txt"
}

generate_threat_report() {
{
echo "=== THREAT HUNTING REPORT ==="
echo "Generated: $(date)"
echo ""

echo "Summary of Findings:"
echo "- Review persistence_analysis.txt for unauthorized startup mechanisms"
echo "- Review process_anomalies.txt for suspicious processes"
echo "- Review suspicious_files.txt for privilege escalation risks"
echo "- Review network_indicators.txt for unusual connections"

echo ""
echo "Risk Assessment:"
echo "- Multiple failed logins or unknown services may indicate brute-force attempts"
echo "- Unexpected SUID files may indicate privilege escalation vectors"
echo "- Unknown listening ports should be investigated"

echo ""
echo "Recommended Actions:"
echo "1. Remove unauthorized cron jobs or services"
echo "2. Kill suspicious processes"
echo "3. Audit SUID/SGID files"
echo "4. Restrict unnecessary open ports"
echo "5. Continue monitoring with auditd"

} > "$OUTPUT_DIR/threat_report.txt"
}

hunt_persistence
hunt_process_anomalies
hunt_suspicious_files
hunt_network_indicators
generate_threat_report

echo "Threat hunting completed!"
echo "Results saved in: $OUTPUT_DIR"
