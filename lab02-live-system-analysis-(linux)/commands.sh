#!/bin/bash
# Lab 02 – Live System Analysis (Linux)
# Commands Executed During Lab

# ==============================
# System Update
# ==============================

sudo apt update


# ==============================
# Install Auditd
# ==============================

sudo apt install -y auditd audispd-plugins

sudo systemctl status auditd
sudo systemctl enable auditd
sudo systemctl start auditd


# ==============================
# Backup Audit Configuration
# ==============================

sudo cp /etc/audit/auditd.conf /etc/audit/auditd.conf.backup
sudo cp /etc/audit/rules.d/audit.rules /etc/audit/rules.d/audit.rules.backup 2>/dev/null


# ==============================
# Create Custom Audit Rules
# ==============================

sudo nano /etc/audit/rules.d/forensic.rules

sudo augenrules --load
sudo systemctl restart auditd

sudo auditctl -l


# ==============================
# Create Forensic Analysis Directory
# ==============================

mkdir -p ~/forensic_analysis
cd ~/forensic_analysis
pwd


# ==============================
# System Information Collector
# ==============================

nano system_info_collector.sh
chmod +x system_info_collector.sh
ls -l system_info_collector.sh

./system_info_collector.sh
ls
ls system_analysis_*
cat system_analysis_*/system_info.txt


# ==============================
# Audit Log Analyzer
# ==============================

nano audit_analyzer.sh
chmod +x audit_analyzer.sh
ls -l audit_analyzer.sh

# Generate Audit Activity
sudo cat /etc/passwd > /dev/null
sudo ls /root > /dev/null
sudo echo "Test" >> /etc/hosts

./audit_analyzer.sh

ls
ls audit_analysis_*
cat audit_analysis_*/identity_changes.txt
cat audit_analysis_*/analysis_summary.txt


# ==============================
# Log Correlation Script
# ==============================

nano log_correlator.sh
chmod +x log_correlator.sh

./log_correlator.sh

ls correlation_analysis_*
cat correlation_analysis_*/ioc_analysis.txt


# ==============================
# Threat Hunting Script
# ==============================

nano threat_hunter.sh
chmod +x threat_hunter.sh
ls -l threat_hunter.sh

./threat_hunter.sh

ls threat_hunting_*
cat threat_hunting_*/threat_report.txt
cat threat_hunting_*/persistence_analysis.txt | head -30
cat threat_hunting_*/process_anomalies.txt | head -30


# ==============================
# Final Forensic Report
# ==============================

nano final_report.txt
cat final_report.txt
