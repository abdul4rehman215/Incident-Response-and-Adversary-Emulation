#!/bin/bash

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
AUDIT_LOG="/var/log/audit/audit.log"
OUTPUT_DIR="audit_analysis_$TIMESTAMP"

mkdir -p "$OUTPUT_DIR"

echo "=== Starting Audit Log Analysis ==="

if [ ! -f "$AUDIT_LOG" ]; then
    echo "Audit log not found at $AUDIT_LOG"
    exit 1
fi

analyze_events() {
    local event_key="$1"
    local description="$2"
    local output_file="$3"

    {
        echo "=== $description ==="
        echo "Analysis Date: $(date)"
        echo ""

        echo "Total Events:"
        sudo ausearch -k "$event_key" | grep -c "type="

        echo ""
        echo "Event Details:"
        sudo ausearch -k "$event_key"

    } > "$OUTPUT_DIR/$output_file"
}

analyze_failed_syscalls() {
    {
        echo "=== FAILED SYSTEM CALLS ==="
        echo "Analysis Date: $(date)"
        echo ""
        sudo ausearch -m SYSCALL -sv no
        echo ""
        echo "Total Failed System Calls:"
        sudo ausearch -m SYSCALL -sv no | grep -c "type=SYSCALL"
    } > "$OUTPUT_DIR/failed_syscalls.txt"
}

generate_summary() {
    {
        echo "=== AUDIT ANALYSIS SUMMARY ==="
        echo "Generated: $(date)"
        echo ""

        echo "Identity Events Count:"
        sudo ausearch -k identity | grep -c "type="

        echo "Login Events Count:"
        sudo ausearch -k logins | grep -c "type="

        echo "Process Execution Events Count:"
        sudo ausearch -k process_execution | grep -c "type="

        echo "Privilege Escalation Events Count:"
        sudo ausearch -k privilege_escalation | grep -c "type="

        echo ""
        echo "Top Users Performing Actions:"
        sudo ausearch -m USER_CMD | awk '/acct=/{print $0}' | sort | uniq -c | sort -nr | head -10

    } > "$OUTPUT_DIR/analysis_summary.txt"
}

analyze_events "identity" "IDENTITY FILE CHANGES" "identity_changes.txt"
analyze_events "logins" "LOGIN EVENTS" "login_events.txt"
analyze_events "process_execution" "PROCESS EXECUTION EVENTS" "process_execution.txt"
analyze_events "privilege_escalation" "PRIVILEGE ESCALATION EVENTS" "privilege_escalation.txt"

analyze_failed_syscalls
generate_summary

echo "Audit log analysis completed!"
echo "Results saved in: $OUTPUT_DIR"
