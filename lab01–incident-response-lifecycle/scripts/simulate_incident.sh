#!/bin/bash

echo "Simulating suspicious activity for detection practice..."

echo "This is a suspicious file created for incident response training" > /tmp/suspicious_file.txt

yes > /dev/null &
SUSPICIOUS_PID=$!

echo $SUSPICIOUS_PID > /tmp/suspicious_process.pid

NETWORK_LOG="$HOME/incident_response/logs/network/suspicious_activity.log"
mkdir -p "$HOME/incident_response/logs/network"

echo "$(date): Suspicious connection attempt from 192.168.1.100 to port 22" >> "$NETWORK_LOG"

echo '#!/bin/bash' > /tmp/fake_malware.sh
echo 'echo "Fake malware executed at $(date)" >> /tmp/malware_log.txt' >> /tmp/fake_malware.sh

chmod +x /tmp/fake_malware.sh

echo "Suspicious activity simulation complete."
echo "Suspicious PID: $SUSPICIOUS_PID (saved to /tmp/suspicious_process.pid)"
