#!/bin/bash

echo "=== INCIDENT RESPONSE PLAYBOOK ==="

echo "Phase 1: Preparation - COMPLETE"
echo "Phase 2: Identification - IN PROGRESS"
echo "Phase 3: Containment - PENDING"
echo "Phase 4: Eradication - PENDING"
echo "Phase 5: Recovery - PENDING"
echo "Phase 6: Lessons Learned - PENDING"
echo

# Incident classification
classify_incident() {
    echo "INCIDENT CLASSIFICATION:"
    echo "- Type: Multi-vector Attack"
    echo "- Severity: HIGH"
    echo "- Priority: P1 (Critical)"
    echo "- Affected Systems: Web Server, Network Infrastructure"
    echo "- Business Impact: Potential data breach, service disruption"
    echo
}

# Evidence collection
collect_evidence() {
    echo "EVIDENCE COLLECTION:"

    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    EVIDENCE_DIR=~/incident-response-lab/evidence/$TIMESTAMP

    mkdir -p $EVIDENCE_DIR

    # Collect system information
    uname -a > $EVIDENCE_DIR/system_info.txt
    ps aux > $EVIDENCE_DIR/running_processes.txt
    netstat -tulpn > $EVIDENCE_DIR/network_connections.txt

    # Collect security logs
    sudo cp /var/ossec/logs/alerts/alerts.log \
        $EVIDENCE_DIR/wazuh_alerts.log

    sudo cp /var/log/suricata/fast.log \
        $EVIDENCE_DIR/suricata_alerts.log

    sudo cp /opt/zeek/logs/current/conn.log \
        $EVIDENCE_DIR/zeek_connections.log

    echo "Evidence collected in: $EVIDENCE_DIR"
    echo
}

classify_incident
collect_evidence
