#!/bin/bash

echo "=== ERADICATION AND RECOVERY PROCEDURES ==="
echo

# ERADICATION
echo "Phase 1: ERADICATION"

echo "1. Removing malware and malicious files..."

sudo rm -rf /quarantine/* 2>/dev/null
sudo find /tmp -name "*.exe" -delete
sudo find /tmp -name "suspicious*" -delete

sudo apt update
sudo apt install -y clamav clamav-daemon

sudo freshclam
sudo clamscan -r /home --infected --remove

echo "Malware removal completed"
echo

echo "2. Patching vulnerabilities..."

sudo apt upgrade -y

if [ -f /etc/apache2/apache2.conf ]; then
    sudo sed -i 's/ServerTokens OS/ServerTokens Prod/' \
        /etc/apache2/conf-available/security.conf
    sudo sed -i 's/ServerSignature On/ServerSignature Off/' \
        /etc/apache2/conf-available/security.conf
    sudo systemctl restart apache2
fi

echo "System hardening completed"
echo

# RECOVERY
echo "Phase 2: RECOVERY"

echo "1. Restoring services..."

sudo systemctl restart wazuh-manager
sudo systemctl restart wazuh-agent
sudo systemctl restart suricata
sudo /opt/zeek/bin/zeekctl restart

echo "Service status verification:"
sudo systemctl status wazuh-manager --no-pager -l
sudo systemctl status suricata --no-pager -l
echo

echo "2. Implementing additional monitoring..."

sudo tee -a /var/ossec/etc/ossec.conf << 'MONITORING_EOF'
<localfile>
<log_format>syslog</log_format>
<location>/var/log/auth.log</location>
</localfile>
<localfile>
<log_format>apache</log_format>
<location>/var/log/apache2/access.log</location>
</localfile>
MONITORING_EOF

sudo systemctl restart wazuh-manager

echo "Enhanced monitoring implemented"
echo

echo "3. Backup and documentation..."

sudo tar -czf \
  ~/incident-response-lab/evidence/system_backup_$(date +%Y%m%d).tar.gz \
  /etc /var/log

echo "System backup created"
echo
echo "=== ERADICATION AND RECOVERY COMPLETE ==="
