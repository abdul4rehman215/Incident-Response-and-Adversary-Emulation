#!/bin/bash

LOG_FILE="/var/log/suricata/eve.json"
INCIDENT_DIR="/tmp/incident_$(date +%Y%m%d_%H%M%S)"

echo "=== Incident Response Playbook ==="
echo "Creating incident directory: $INCIDENT_DIR"

mkdir -p "$INCIDENT_DIR"

# Step 1: Collect recent alerts
echo "Step 1: Collecting recent alerts..."
sudo cat $LOG_FILE | jq 'select(.event_type=="alert")' > "$INCIDENT_DIR/alerts.json"

# Step 2: Identify high-severity alerts
echo "Step 2: Identifying high-severity alerts..."
sudo cat $LOG_FILE | jq 'select(.event_type=="alert" and .alert.severity <= 2)' > "$INCIDENT_DIR/high_severity_alerts.json"

# Step 3: Extract unique source IPs
echo "Step 3: Extracting suspicious source IPs..."
sudo cat $LOG_FILE | jq -r 'select(.event_type=="alert") | .src_ip' | sort | uniq > "$INCIDENT_DIR/suspicious_ips.txt"

# Step 4: Generate timeline
echo "Step 4: Generating incident timeline..."
sudo cat $LOG_FILE | jq -r 'select(.event_type=="alert") | "\(.timestamp) | \(.alert.signature) | \(.src_ip) -> \(.dest_ip)"' | sort > "$INCIDENT_DIR/timeline.txt"

# Step 5: Create summary report
echo "Step 5: Creating summary report..."
cat > "$INCIDENT_DIR/incident_summary.txt" << EOF
Incident Response Summary
Generated: $(date)

Total Alerts: $(wc -l < "$INCIDENT_DIR/alerts.json")
High Severity Alerts: $(wc -l < "$INCIDENT_DIR/high_severity_alerts.json")
Unique Source IPs: $(wc -l < "$INCIDENT_DIR/suspicious_ips.txt")

Top 5 Alert Types:
$(sudo cat $LOG_FILE | jq -r 'select(.event_type=="alert") | .alert.signature' | sort | uniq -c | sort -nr | head -5)

Recommended Actions:
1. Review high-severity alerts in detail
2. Investigate suspicious source IPs
3. Check for patterns in the timeline
4. Consider blocking malicious IPs
5. Update detection rules if needed
EOF

echo "Incident response data collected in: $INCIDENT_DIR"
echo "Review the following files:"
ls -1 "$INCIDENT_DIR"
