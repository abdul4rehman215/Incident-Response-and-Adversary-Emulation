#!/bin/bash
# ==============================================================
# Lab 08 - Web Reconnaissance with Maltego
# Environment: Ubuntu 24.04.1 LTS
# User: toor
# ==============================================================

# --------------------------------------------------------------
# Task 1: System Update
# --------------------------------------------------------------

sudo apt update && sudo apt upgrade -y

# --------------------------------------------------------------
# Install Java (Required for Maltego)
# --------------------------------------------------------------

sudo apt install default-jre default-jdk -y

java -version

# --------------------------------------------------------------
# Download Maltego Community Edition
# --------------------------------------------------------------

cd ~/Downloads
wget https://maltego-downloads.s3.us-east-2.amazonaws.com/linux/Maltego.v4.5.0.deb

# --------------------------------------------------------------
# Install Maltego
# --------------------------------------------------------------

sudo dpkg -i Maltego.v4.5.0.deb
sudo apt-get install -f -y

# Verify Installation
maltego --version

cd ~

# --------------------------------------------------------------
# Install Supporting OSINT Tools
# --------------------------------------------------------------

# Install theHarvester
sudo apt install theharvester -y

# Install Sublist3r
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r
pip3 install -r requirements.txt
cd ~

# Install Recon-ng
git clone https://github.com/lanmaster53/recon-ng.git
cd recon-ng
pip3 install -r REQUIREMENTS
cd ~

# Install Shodan CLI
pip3 install shodan

# Install DNSrecon
sudo apt install dnsrecon -y

# --------------------------------------------------------------
# Launch Maltego (GUI)
# --------------------------------------------------------------

maltego &

# --------------------------------------------------------------
# Task 2: Email Enumeration using theHarvester
# --------------------------------------------------------------

theharvester -d example-target.com -l 100 -b google,bing,yahoo > harvester_results.txt
cat harvester_results.txt

# --------------------------------------------------------------
# Task 3: Subdomain Enumeration with Sublist3r
# --------------------------------------------------------------

cd ~/Sublist3r
python3 sublist3r.py -d example-target.com -o subdomains.txt
cat subdomains.txt

echo "Discovered Subdomains:" > maltego_subdomains.txt
cat subdomains.txt >> maltego_subdomains.txt

cd ~

# --------------------------------------------------------------
# DNS Reconnaissance with DNSrecon
# --------------------------------------------------------------

dnsrecon -d example-target.com -t std > dns_recon_results.txt
dnsrecon -d example-target.com -t axfr >> dns_recon_results.txt

grep " A " dns_recon_results.txt > a_records.txt
grep " MX " dns_recon_results.txt > mx_records.txt
grep " NS " dns_recon_results.txt > ns_records.txt

# --------------------------------------------------------------
# Recon-ng Manual Execution
# --------------------------------------------------------------

cd ~/recon-ng
python3 recon-ng

# Inside recon-ng console:
# marketplace install hackertarget
# modules load recon/domains-hosts/hackertarget
# options set SOURCE example-target.com
# run
# show hosts
# exit

cd ~

# --------------------------------------------------------------
# Run Recon-ng Automation Script
# --------------------------------------------------------------

chmod +x recon_automation.py
python3 recon_automation.py example-target.com

# --------------------------------------------------------------
# Email Analysis Script
# --------------------------------------------------------------

chmod +x email_analysis.py
python3 email_analysis.py

# --------------------------------------------------------------
# Network Analysis Script
# --------------------------------------------------------------

chmod +x network_analysis.py
python3 network_analysis.py

# --------------------------------------------------------------
# Custom Maltego Transform Test
# --------------------------------------------------------------

chmod +x custom_subdomain_transform.py
python3 custom_subdomain_transform.py example-target.com

# --------------------------------------------------------------
# Maltego Report Generator
# (After exporting CSV from GUI)
# --------------------------------------------------------------

chmod +x maltego_report_generator.py
python3 maltego_report_generator.py

# --------------------------------------------------------------
# Integration Verification Script
# --------------------------------------------------------------

chmod +x verify_integration.py
python3 verify_integration.py

# --------------------------------------------------------------
# Performance Testing
# --------------------------------------------------------------

chmod +x performance_test.py
python3 performance_test.py

# --------------------------------------------------------------
# Tool Path Verification (Troubleshooting)
# --------------------------------------------------------------

which theharvester
which dnsrecon
which python3
pip3 list | grep -E "(requests|beautifulsoup4|dnspython)"

# --------------------------------------------------------------
# End of Lab 08 Commands
# --------------------------------------------------------------
