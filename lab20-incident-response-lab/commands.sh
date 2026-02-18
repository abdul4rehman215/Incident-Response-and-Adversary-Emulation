#!/bin/bash

############################################################
# LAB 20 – FINAL INCIDENT RESPONSE SIMULATION
# All Commands Executed During Lab
############################################################

###############################
# TASK 1 – ENVIRONMENT SETUP
###############################

# Update system
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y curl wget gnupg2 software-properties-common apt-transport-https ca-certificates

# Create lab directory structure
mkdir -p ~/incident-response-lab/{logs,scripts,evidence,reports}
cd ~/incident-response-lab
ls -la

###############################
# TASK 1.2 – INSTALL WAZUH
###############################

# Add Wazuh GPG key
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo apt-key add -

# Add Wazuh repository
echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | sudo tee /etc/apt/sources.list.d/wazuh.list

# Update package list
sudo apt update

# Install Wazuh Manager
sudo apt install -y wazuh-manager

# Enable and start manager
sudo systemctl enable wazuh-manager
sudo systemctl start wazuh-manager
sudo systemctl status wazuh-manager

# Install Wazuh API
sudo apt install -y wazuh-api

# Configure API
sudo /var/ossec/api/scripts/configure_api.sh

# Enable and start API
sudo systemctl enable wazuh-api
sudo systemctl start wazuh-api

# Install Wazuh Agent
sudo apt install -y wazuh-agent

# Configure agent to local manager
sudo sed -i 's/<server>.*<\/server>/<server>127.0.0.1<\/server>/' /var/ossec/etc/ossec.conf

# Enable and start agent
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
sudo systemctl status wazuh-agent

###############################
# TASK 1.3 – INSTALL SURICATA
###############################

sudo apt install -y suricata

# Update Suricata rules
sudo suricata-update

# Detect active interface
INTERFACE=$(ip route | grep default | awk '{print $5}' | head -1)
echo $INTERFACE

# Update Suricata interface
sudo sed -i "s/interface: eth0/interface: $INTERFACE/" /etc/suricata/suricata.yaml

# Enable JSON output
sudo sed -i 's/enabled: no/enabled: yes/' /etc/suricata/suricata.yaml

# Enable and start Suricata
sudo systemctl enable suricata
sudo systemctl start suricata
sudo systemctl status suricata

###############################
# TASK 1.4 – INSTALL ZEEK
###############################

sudo apt install -y zeek

# Add Zeek to PATH
echo 'export PATH=/opt/zeek/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Configure Zeek interface
INTERFACE=$(ip route | grep default | awk '{print $5}' | head -1)
echo "interface=$INTERFACE" | sudo tee /opt/zeek/etc/node.cfg

# Install Zeek control scripts
sudo /opt/zeek/bin/zeekctl install

# Start Zeek
sudo /opt/zeek/bin/zeekctl start
sudo /opt/zeek/bin/zeekctl status

###############################
# TASK 1.5 – LOG INTEGRATION
###############################

# Add Suricata log to Wazuh
sudo tee -a /var/ossec/etc/ossec.conf << 'EOF'
<localfile>
<log_format>json</log_format>
<location>/var/log/suricata/eve.json</location>
</localfile>
EOF

# Add Zeek logs to Wazuh
sudo tee -a /var/ossec/etc/ossec.conf << 'EOF'
<localfile>
<log_format>syslog</log_format>
<location>/opt/zeek/logs/current/conn.log</location>
</localfile>
<localfile>
<log_format>syslog</log_format>
<location>/opt/zeek/logs/current/dns.log</location>
</localfile>
<localfile>
<log_format>syslog</log_format>
<location>/opt/zeek/logs/current/http.log</location>
</localfile>
EOF

# Restart Wazuh
sudo systemctl restart wazuh-manager

###############################
# TASK 2 – ATTACK SIMULATION
###############################

# Make scripts executable
chmod +x ~/incident-response-lab/scripts/port_scan_simulation.sh
chmod +x ~/incident-response-lab/scripts/web_attack_simulation.sh
chmod +x ~/incident-response-lab/scripts/malware_simulation.sh

# Execute Port Scan Simulation
echo "Executing port scan simulation..."
~/incident-response-lab/scripts/port_scan_simulation.sh
sleep 10

# Execute Web Attack Simulation
echo "Executing web attack simulation..."
~/incident-response-lab/scripts/web_attack_simulation.sh
sleep 10

# Execute Malware Simulation
echo "Executing malware simulation..."
~/incident-response-lab/scripts/malware_simulation.sh
sleep 10

###############################
# DETECTION VALIDATION
###############################

# Check Wazuh alerts
sudo tail -50 /var/ossec/logs/alerts/alerts.log

# Check Suricata alerts
sudo tail -50 /var/log/suricata/fast.log

# Check Zeek logs
sudo tail -20 /opt/zeek/logs/current/conn.log

###############################
# TASK 3 – INCIDENT RESPONSE
###############################

chmod +x ~/incident-response-lab/scripts/incident_response_playbook.sh
~/incident-response-lab/scripts/incident_response_playbook.sh

ls -la ~/incident-response-lab/evidence/

chmod +x ~/incident-response-lab/scripts/containment_procedures.sh
sudo ~/incident-response-lab/scripts/containment_procedures.sh

sudo iptables -L -n

chmod +x ~/incident-response-lab/scripts/eradication_recovery.sh
~/incident-response-lab/scripts/eradication_recovery.sh

ls -lh ~/incident-response-lab/evidence/

chmod +x ~/incident-response-lab/scripts/post_incident_analysis.sh
~/incident-response-lab/scripts/post_incident_analysis.sh

ls -la ~/incident-response-lab/reports/

###############################
# TASK 4 – VERIFICATION
###############################

chmod +x ~/incident-response-lab/scripts/security_verification.sh
~/incident-response-lab/scripts/security_verification.sh

chmod +x ~/incident-response-lab/scripts/compile_documentation.sh
~/incident-response-lab/scripts/compile_documentation.sh

ls -lah ~/incident-response-lab/final_documentation/

############################################################
# END OF LAB 20 COMMANDS
############################################################
