#!/bin/bash
# Lab 07 – OSINT with theHarvester
# Commands Executed

# ----------------------------------------
# Task 1: Installing and Configuring theHarvester
# ----------------------------------------

# Update system
sudo apt update

# Install required packages
sudo apt install python3 python3-pip git -y

# Install additional dependencies
sudo apt install python3-requests python3-beautifulsoup4 -y

# Navigate to home
cd ~
pwd

# Clone theHarvester repository
git clone https://github.com/laramies/theHarvester.git

# Navigate into directory
cd theHarvester
ls

# Upgrade pip
pip3 install --upgrade pip

# Install requirements
pip3 install -r requirements.txt

# Make executable
chmod +x theHarvester.py

# Verify installation
python3 theHarvester.py -h
python3 theHarvester.py -h | grep -A 20 "engines"

# ----------------------------------------
# Task 2: Basic OSINT Gathering
# ----------------------------------------

# Email harvesting
python3 theHarvester.py -d example.com -l 100 -b google
python3 theHarvester.py -d example.com -l 100 -b google,bing,yahoo
python3 theHarvester.py -d example.com -l 100 -b google,bing -f example_emails

# Subdomain enumeration
python3 theHarvester.py -d example.com -l 200 -b dnsdumpster
python3 theHarvester.py -d example.com -l 200 -b dnsdumpster,crtsh,virustotal
python3 theHarvester.py -d example.com -l 200 -b dnsdumpster,crtsh -f example_subdomains

# Comprehensive scan
python3 theHarvester.py -d example.com -l 300 -b all -f comprehensive_scan
python3 theHarvester.py -d example.com -l 200 -b google,bing,dnsdumpster,crtsh,virustotal -f balanced_scan

# ----------------------------------------
# Task 3: Advanced Techniques
# ----------------------------------------

# Create API key directory
mkdir -p ~/.theHarvester

# Create API keys file
nano ~/.theHarvester/api-keys.yaml

# Passive DNS reconnaissance
python3 theHarvester.py -d example.com -l 150 -b passivetotal
python3 theHarvester.py -d example.com -l 150 -b crtsh,certspotter

# Social media reconnaissance
python3 theHarvester.py -d example.com -l 100 -b linkedin
python3 theHarvester.py -d example.com -l 100 -b twitter

# ----------------------------------------
# Task 4: Automation Scripts
# ----------------------------------------

# Create automation script
nano harvester_automation.py
chmod +x harvester_automation.py
python3 harvester_automation.py example.com
ls -la harvester_reports

# Create advanced processor
nano advanced_processor.py
chmod +x advanced_processor.py
python3 advanced_processor.py example.com
ls -la *.csv *.json

# ----------------------------------------
# Task 5: Practical OSINT Scenarios
# ----------------------------------------

# Incident Response simulation
mkdir incident_response_lab
cd incident_response_lab
python3 ~/theHarvester/theHarvester.py -d example.com -l 500 -b all -f incident_analysis
python3 ~/advanced_processor.py example.com

# Adversary emulation
cd ~
mkdir adversary_emulation
cd adversary_emulation

# Phase 1
python3 ~/theHarvester/theHarvester.py -d example.com -l 100 -b google,bing -f phase1_recon

# Phase 2
python3 ~/theHarvester/theHarvester.py -d example.com -l 300 -b dnsdumpster,crtsh,virustotal -f phase2_enum

# Phase 3
python3 ~/theHarvester/theHarvester.py -d example.com -l 200 -b linkedin,twitter -f phase3_social

# ----------------------------------------
# Task 6: Manual Data Analysis
# ----------------------------------------

cd ~/theHarvester

grep -i "@" *.txt | sort | uniq > unique_emails.txt
grep -E "([a-zA-Z0-9-]+.)+[a-zA-Z]{2,}" *.txt | sort | uniq > unique_subdomains.txt

echo "Email addresses found: $(wc -l < unique_emails.txt)"
echo "Subdomains found: $(wc -l < unique_subdomains.txt)"

# Visualization script
cd ~
nano visualize_results.py
chmod +x visualize_results.py
python3 visualize_results.py comprehensive_report_example.com_20260217_143104.json

# ----------------------------------------
# Task 7: Legal & Ethical Controls
# ----------------------------------------

# Legal checklist
nano osint_legal_checklist.txt
cat osint_legal_checklist.txt

# Rate limiting script
nano rate_limited_harvest.py
chmod +x rate_limited_harvest.py
python3 rate_limited_harvest.py example.com google,bing

# ----------------------------------------
# Lab Verification
# ----------------------------------------

cd ~/theHarvester
python3 theHarvester.py -h | head -10
python3 theHarvester.py -d example.com -l 10 -b google

cd ~
python3 harvester_automation.py example.com
ls -la *.html *.json *.csv
python3 advanced_processor.py example.com
