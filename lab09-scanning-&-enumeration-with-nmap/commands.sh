#!/bin/bash
# =========================================
# Lab 09 – Scanning & Enumeration with Nmap
# Complete Command Execution Log
# =========================================

# -------------------------------
# Task 1: Verify Installation
# -------------------------------

nmap --version

sudo apt update
sudo apt install nmap -y

which nmap

ip addr show
hostname -I

# -------------------------------
# Host Discovery
# -------------------------------

# Ping Scan (Subnet)
nmap -sn 127.0.0.0/24

# Scan Localhost
nmap -sn 127.0.0.1

# ARP Scan
sudo nmap -PR 127.0.0.1

# Create Target List
echo "127.0.0.1" > targets.txt
echo "localhost" >> targets.txt
cat targets.txt

# -------------------------------
# Basic Port Scanning
# -------------------------------

# Default Top 1000 Ports
nmap 127.0.0.1

# Specific Ports
nmap -p 22,80,443,3306 127.0.0.1

# Port Range
nmap -p 1-1000 127.0.0.1

# Full Port Scan
nmap -p- 127.0.0.1

# -------------------------------
# Advanced Scanning
# -------------------------------

# SYN Scan
sudo nmap -sS 127.0.0.1

# UDP Scan
sudo nmap -sU 127.0.0.1

# Combined TCP & UDP
sudo nmap -sS -sU -p 1-100 127.0.0.1

# Aggressive Scan
nmap -A 127.0.0.1

# -------------------------------
# Service & OS Detection
# -------------------------------

nmap -sV 127.0.0.1
nmap -sV --version-intensity 9 127.0.0.1
sudo nmap -O 127.0.0.1
sudo nmap -sV -O 127.0.0.1

# -------------------------------
# NSE Scripts
# -------------------------------

ls /usr/share/nmap/scripts/ | head -20
nmap -sC 127.0.0.1
nmap --script vuln 127.0.0.1
nmap --script http-enum 127.0.0.1
nmap --script-help http-enum

# -------------------------------
# Create Automation Script
# -------------------------------

nano nmap_scanner.sh
chmod +x nmap_scanner.sh
./nmap_scanner.sh 127.0.0.1

chmod +x advanced_nmap_scanner.sh
./advanced_nmap_scanner.sh -t 127.0.0.1 -p 22,80,443,3306 -o test_scan
./advanced_nmap_scanner.sh -f targets.txt -a -o multi_target_scan

# -------------------------------
# Verify Output Directory
# -------------------------------

ls -la nmap_results_*/
cat nmap_results_*/scan_summary_report.txt

# -------------------------------
# Advanced Multi-Target Scanner
# -------------------------------

nano advanced_nmap_scanner.sh
chmod +x advanced_nmap_scanner.sh

./advanced_nmap_scanner.sh -t 127.0.0.1 -p 22,80,443,3306 -o test_scan
./advanced_nmap_scanner.sh -f targets.txt -a -o multi_target_scan

# -------------------------------
# Extract Key Findings
# -------------------------------

cat nmap_results_*/quick_scan.txt
cat nmap_results_*/service_detection.txt

grep "open" nmap_results_*/quick_scan.txt
grep "open" nmap_results_*/service_detection.txt | grep -v "filtered"

# -------------------------------
# Analysis Script
# -------------------------------

grep "open" nmap_results_*/quick_scan.txt
grep "open" nmap_results_*/service_detection.txt | grep -v "filtered"

nano analyze_results.sh
chmod +x analyze_results.sh

./analyze_results.sh nmap_results_20260217_181245

# -------------------------------
# Service Verification (Troubleshooting)
# -------------------------------

sudo systemctl start ssh
sudo systemctl start apache2
sudo ss -tlnp

# -------------------------------
# Timing Optimization Tests
# -------------------------------

nmap -T5 127.0.0.1
nmap -T4 127.0.0.1
nmap -T2 127.0.0.1

# -------------------------------
# Debug Script
# -------------------------------

bash -n nmap_scanner.sh
bash -x nmap_scanner.sh

# =========================================
# End of Lab 09 Commands
# =========================================
