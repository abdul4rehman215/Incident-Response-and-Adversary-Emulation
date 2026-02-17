#!/bin/bash

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_DIR="correlation_analysis_$TIMESTAMP"

mkdir -p "$OUTPUT_DIR"

echo "=== Starting Log Correlation Analysis ==="

analyze_auth_logs() {
{
echo "=== AUTHENTICATION LOG ANALYSIS ==="
echo "SSH Connection Attempts:"
grep "sshd" /var/log/auth.log 2>/dev/null

echo ""
echo "Failed Authentication Attempts:"
grep "Failed password" /var/log/auth.log 2>/dev/null

echo ""
echo "Successful Authentications:"
grep "Accepted password" /var/log/auth.log 2>/dev/null

echo ""
echo "Sudo Usage:"
grep "sudo" /var/log/auth.log 2>/dev/null
} > "$OUTPUT_DIR/auth_analysis.txt"
}

analyze_system_logs() {
{
echo "=== SYSTEM LOG ANALYSIS ==="
echo "Recent System Messages:"
tail -n 50 /var/log/syslog 2>/dev/null

echo ""
echo "Error Messages:"
grep -i "error" /var/log/syslog 2>/dev/null

echo ""
echo "Service Start/Stop Events:"
grep -E "Started|Stopped" /var/log/syslog 2>/dev/null
} > "$OUTPUT_DIR/system_analysis.txt"
}

analyze_network_activity() {
{
echo "=== NETWORK ACTIVITY ANALYSIS ==="
echo "Active Network Connections:"
ss -tunap

echo ""
echo "Listening Services:"
ss -tulnp

echo ""
echo "ARP Table:"
ip neigh
} > "$OUTPUT_DIR/network_analysis.txt"
}

create_timeline() {
{
echo "=== EVENT TIMELINE CORRELATION ==="
echo "Auth Log Events:"
grep -E "$(date '+%b %e')" /var/log/auth.log 2>/dev/null

echo ""
echo "Syslog Events:"
grep -E "$(date '+%b %e')" /var/log/syslog 2>/dev/null

echo ""
echo "Audit Events:"
sudo ausearch -ts today
} > "$OUTPUT_DIR/timeline_correlation.txt"
}

identify_iocs() {
{
echo "=== INDICATORS OF COMPROMISE ==="

FAILED_SSH=$(grep -c "Failed password" /var/log/auth.log 2>/dev/null)
echo "Failed SSH Attempts: $FAILED_SSH"

if [ "$FAILED_SSH" -ge 10 ]; then
    echo "WARNING: Multiple failed SSH attempts detected!"
fi

echo ""
echo "Unusual High CPU Processes:"
ps aux --sort=-%cpu | head -5

echo ""
echo "Processes Running from /tmp:"
ps aux | grep "/tmp" | grep -v grep

echo ""
echo "System Load:"
uptime
} > "$OUTPUT_DIR/ioc_analysis.txt"
}

generate_report() {
{
echo "=== COMPREHENSIVE FORENSIC REPORT ==="
echo "Generated: $(date)"
echo ""

echo "Analysis Files Generated:"
ls -1 "$OUTPUT_DIR"

echo ""
echo "Key Findings:"
echo "- Review auth_analysis.txt for authentication anomalies"
echo "- Review system_analysis.txt for system errors"
echo "- Review network_analysis.txt for suspicious connections"
echo "- Review ioc_analysis.txt for potential compromise indicators"

echo ""
echo "Recommendations:"
echo "- Investigate repeated failed logins"
echo "- Review high CPU processes"
echo "- Monitor suspicious network activity"
echo "- Maintain audit logging enabled"
} > "$OUTPUT_DIR/forensic_report.txt"
}

analyze_auth_logs
analyze_system_logs
analyze_network_activity
create_timeline
identify_iocs
generate_report

echo "Log correlation analysis completed!"
echo "Results saved in: $OUTPUT_DIR"
