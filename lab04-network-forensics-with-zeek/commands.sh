#!/bin/bash

# ==============================================================
# LAB 04 — Network Forensics with Zeek
# Commands Executed During Lab
# ==============================================================

# -------------------------------
# System Update
# -------------------------------
sudo apt update && sudo apt upgrade -y

# -------------------------------
# Install Required Packages
# -------------------------------
sudo apt install -y \
cmake \
make \
gcc \
g++ \
flex \
bison \
libpcap-dev \
libssl-dev \
python3-dev \
swig \
zlib1g-dev \
zeek \
tcpdump \
jq

# -------------------------------
# Verify Installation
# -------------------------------
zeek --version
which zeek

# -------------------------------
# Verify Network Interface
# -------------------------------
ip link show
ip route | grep default | awk '{print $5}' | head -1

# -------------------------------
# Create Working Directory
# -------------------------------
mkdir -p ~/zeek-lab
cd ~/zeek-lab

# -------------------------------
# Generate HTTP Traffic
# -------------------------------
curl -s http://httpbin.org/get > /dev/null &
curl -s http://httpbin.org/user-agent > /dev/null &
curl -s http://example.com > /dev/null &

# -------------------------------
# Generate DNS Queries
# -------------------------------
nslookup google.com > /dev/null &
nslookup github.com > /dev/null &
nslookup malicious-domain-example.com > /dev/null &

sleep 5

# -------------------------------
# Capture Traffic with Zeek
# -------------------------------
sudo timeout 30 zeek -i ens5 local.zeek

# -------------------------------
# Examine Logs
# -------------------------------
ls -la *.log
head -5 conn.log
head -5 dns.log
head -5 http.log
head -1 conn.log | jq .

# -------------------------------
# Create Detection Scripts
# -------------------------------
nano malicious_domains.zeek
nano port_scan_detector.zeek
nano suspicious_user_agents.zeek
nano comprehensive_detection.zeek

# -------------------------------
# Create Test Traffic Generator
# -------------------------------
nano generate_test_traffic.sh
chmod +x generate_test_traffic.sh

# -------------------------------
# Run Zeek with Comprehensive Detection
# -------------------------------
sudo timeout 60 zeek -i ens5 comprehensive_detection.zeek &
sleep 5
./generate_test_traffic.sh
wait

# -------------------------------
# Analyze Detection Results
# -------------------------------
cat malicious_activity.log

echo "DNS Suspicious: $(grep -c DNS_SUSPICIOUS malicious_activity.log)"
echo "HTTP Suspicious: $(grep -c HTTP_SUSPICIOUS malicious_activity.log)"
echo "Port Scans: $(grep -c PORT_SCAN malicious_activity.log)"
echo "User Agents: $(grep -c SUSPICIOUS_USER_AGENT malicious_activity.log)"

echo "Total connections logged: $(wc -l < conn.log)"
echo "Total DNS queries: $(wc -l < dns.log)"
echo "Total HTTP requests: $(wc -l < http.log)"

# -------------------------------
# Create Python Forensic Analyzer
# -------------------------------
nano forensic_analysis.py
chmod +x forensic_analysis.py

# -------------------------------
# Create Timeline Script
# -------------------------------
nano timeline_analysis.sh
chmod +x timeline_analysis.sh
./timeline_analysis.sh

# -------------------------------
# Generate Final Security Report
# -------------------------------
nano generate_final_report.sh
chmod +x generate_final_report.sh
./generate_final_report.sh

# -------------------------------
# Verify Report
# -------------------------------
ls -lh zeek_security_report_*.txt
