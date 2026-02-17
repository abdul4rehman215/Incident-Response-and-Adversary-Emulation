#!/bin/bash
# ================================================
# LAB 6 — Analyzing DNS Traffic
# Complete Command Execution Log
# Environment:
# Ubuntu 24.04 LTS
# Host: ip-172-31-10-198
# User: toor
# Interface: ens5
# ================================================


echo "=============================="
echo "TASK 1 — DNS TRAFFIC CAPTURE"
echo "=============================="

# Identify network interface
ip addr show

# Capture live DNS traffic
sudo tcpdump -i ens5 -n port 53

# Generate DNS traffic
nslookup google.com
nslookup github.com
nslookup amazon.com

# Save DNS traffic to PCAP file
sudo tcpdump -i ens5 -n -w dns_capture.pcap port 53

# Read captured traffic
sudo tcpdump -r dns_capture.pcap -n

# Verbose DNS output
sudo tcpdump -r dns_capture.pcap -n -v


echo "=============================="
echo "TASK 2 — INSTALL PYTHON TOOLS"
echo "=============================="

# Install pip
sudo apt install python3-pip -y

# Install required Python libraries
pip3 install scapy pandas


echo "=============================="
echo "TASK 2 — DNS ANALYZER"
echo "=============================="

# Make analyzer executable
chmod +x dns_analyzer.py

# Run analyzer
python3 dns_analyzer.py dns_capture.pcap


echo "=============================="
echo "TASK 2 — REAL-TIME DNS MONITOR"
echo "=============================="

# Make monitor executable
chmod +x dns_monitor.py

# Run real-time monitor
sudo python3 dns_monitor.py ens5

# Generate suspicious DNS traffic
nslookup malware-control-server.tk

# Simulate beaconing behavior
for i in {1..25}; do
  nslookup beaconing-test.com > /dev/null
  sleep 1
done


echo "=============================="
echo "TASK 3 — DNS TUNNELING DETECTION"
echo "=============================="

# Make tunneling detector executable
chmod +x dns_tunneling_detector.py

# Run tunneling detection
python3 dns_tunneling_detector.py dns_capture.pcap


echo "=============================="
echo "TASK 3 — BASELINE CREATION"
echo "=============================="

# Create DNS baseline
python3 dns_baseline.py --create dns_capture.pcap

# Detect anomalies using baseline
python3 dns_baseline.py --detect dns_capture.pcap baseline.json


echo "=============================="
echo "TASK 4 — DNS REPORT GENERATION"
echo "=============================="

# Make report generator executable
chmod +x dns_report.py

# Generate DNS forensic report
python3 dns_report.py dns_capture.pcap

# View report
cat report.json


echo "=============================="
echo "LAB 6 COMMAND EXECUTION COMPLETE"
echo "=============================="
