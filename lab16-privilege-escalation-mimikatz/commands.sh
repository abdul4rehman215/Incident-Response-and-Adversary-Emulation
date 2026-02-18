#!/bin/bash
# Lab 16 – Privilege Escalation with Mimikatz (Simulated Environment)
# Commands Executed During Lab

# ================================
# Environment Verification
# ================================

cat /etc/os-release
wine --version
pwsh --version
python3 --version
ls -la /opt/lab-tools/

# ================================
# Create Working Directory
# ================================

mkdir -p ~/lab16-mimikatz
cd ~/lab16-mimikatz

# ================================
# Download and Extract Mimikatz
# ================================

wget https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20220919/mimikatz_trunk.zip
unzip mimikatz_trunk.zip
cd mimikatz_trunk/x64

# ================================
# Configure Wine Environment
# ================================

winecfg
winetricks win10
winetricks vcrun2019 dotnet48

# ================================
# Create Simulated Credential Environment
# ================================

cd ~/lab16-mimikatz
nano simulate_credentials.py
chmod +x simulate_credentials.py
python3 simulate_credentials.py

ls -la

# ================================
# Explore Mimikatz
# ================================

cd mimikatz_trunk/x64
wine mimikatz.exe
# Inside Mimikatz console:
# help
# privilege::debug
# sekurlsa::help
# exit

# ================================
# Create Credential Extraction Script
# ================================

cd ~/lab16-mimikatz
nano extract_credentials.py
chmod +x extract_credentials.py
python3 extract_credentials.py

cat extraction_report.json | python3 -m json.tool

# ================================
# Password Security Analysis
# ================================

nano analyze_passwords.py
chmod +x analyze_passwords.py
python3 analyze_passwords.py

# ================================
# Privilege Escalation Assessment
# ================================

nano privilege_check.ps1

pwsh -ExecutionPolicy Bypass -File privilege_check.ps1 -Export -OutputPath "assessment_results.json"

cat assessment_results.json | python3 -m json.tool

# ================================
# Implement Defensive Measures
# ================================

nano implement_defenses.py
chmod +x implement_defenses.py
python3 implement_defenses.py

# ================================
# Credential Monitoring Script
# ================================

nano monitor_credential_access.py
chmod +x monitor_credential_access.py
python3 monitor_credential_access.py
# Stopped with Ctrl+C

# ================================
# End of Lab 16 Commands
# ================================
