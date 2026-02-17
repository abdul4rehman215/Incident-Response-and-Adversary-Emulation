#!/bin/bash

DATE=$(date '+%Y-%m-%d_%H-%M-%S')
CONTAINMENT_LOG="$HOME/incident_response/logs/system/containment_$DATE.log"

mkdir -p "$HOME/incident_response/logs/system"
mkdir -p "$HOME/incident_response/evidence/quarantine"

echo "=== INCIDENT CONTAINMENT ACTIONS ===" > "$CONTAINMENT_LOG"
echo "Containment started at: $(date)" >> "$CONTAINMENT_LOG"

if [ -f /tmp/suspicious_process.pid ]; then
    SUSPICIOUS_PID=$(cat /tmp/suspicious_process.pid)
    echo "Terminating suspicious process PID: $SUSPICIOUS_PID" >> "$CONTAINMENT_LOG"
    kill -9 "$SUSPICIOUS_PID" 2>/dev/null || echo "Process already terminated" >> "$CONTAINMENT_LOG"
fi

pkill -f yes 2>/dev/null
echo "Terminated all 'yes' processes" >> "$CONTAINMENT_LOG"

if [ -f /tmp/suspicious_file.txt ]; then
    mv /tmp/suspicious_file.txt "$HOME/incident_response/evidence/quarantine/"
    echo "Quarantined: suspicious_file.txt" >> "$CONTAINMENT_LOG"
fi

if [ -f /tmp/fake_malware.sh ]; then
    mv /tmp/fake_malware.sh "$HOME/incident_response/evidence/quarantine/"
    echo "Quarantined: fake_malware.sh" >> "$CONTAINMENT_LOG"
fi

echo "Blocking suspicious IP 192.168.1.100 (simulation only)" >> "$CONTAINMENT_LOG"
echo "To block in real scenario use: sudo nft add rule inet filter input ip saddr 192.168.1.100 drop" >> "$CONTAINMENT_LOG"

echo "Containment actions completed at: $(date)" >> "$CONTAINMENT_LOG"

echo "Containment log saved to: $CONTAINMENT_LOG"
