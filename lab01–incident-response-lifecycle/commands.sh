#!/bin/bash
# Lab 01 – Incident Response Lifecycle
# Commands Executed During Lab

# ==============================
# System Update & Tool Installation
# ==============================

sudo apt update && sudo apt upgrade -y

sudo apt install -y \
htop \
iotop \
tcpdump \
wireshark-common \
tshark \
chkrootkit \
rkhunter \
aide \
fail2ban \
rsyslog \
logwatch \
git \
curl \
wget \
unzip \
net-tools \
lsof \
bc


# ==============================
# Directory Structure Creation
# ==============================

mkdir -p ~/incident_response/{logs,evidence,reports,tools,scripts}
cd ~/incident_response

mkdir -p logs/{system,network,application}
mkdir -p evidence/{volatile,non-volatile,timeline,quarantine}
mkdir -p reports/{initial,detailed,final}
mkdir -p tools/{detection,containment,recovery}

tree -L 2


# ==============================
# Script Creation & Permissions
# ==============================

chmod +x scripts/system_monitor.sh
chmod +x scripts/collect_logs.sh
chmod +x scripts/simulate_incident.sh
chmod +x scripts/containment_actions.sh
chmod +x scripts/preserve_evidence.sh
chmod +x scripts/recovery_verification.sh
chmod +x scripts/system_hardening.sh
chmod +x scripts/continuous_monitor.sh
chmod +x scripts/log_cleanup.sh
chmod +x scripts/final_validation.sh


# ==============================
# Detection Phase
# ==============================

./scripts/system_monitor.sh

ls logs/system/
head -20 logs/system/monitor_*.log

ss -tuln > evidence/baseline_network_connections.txt
cat evidence/baseline_network_connections.txt

systemctl list-units --type=service --state=running > evidence/baseline_services.txt
head evidence/baseline_services.txt

sudo aideinit
sudo cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db


# ==============================
# Simulate Incident
# ==============================

./scripts/simulate_incident.sh

ps aux | grep yes
ls -la /tmp | grep suspicious


# ==============================
# Detection Analysis
# ==============================

echo "=== CPU Usage Analysis ===" > evidence/detection_results.txt
top -bn1 | grep -E "(Cpu|PID|yes)" >> evidence/detection_results.txt

echo "" >> evidence/detection_results.txt
echo "=== Suspicious Files Detection ===" >> evidence/detection_results.txt
find /tmp \( -name "*suspicious*" -o -name "*malware*" \) >> evidence/detection_results.txt

echo "" >> evidence/detection_results.txt
echo "=== Network Connection Analysis ===" >> evidence/detection_results.txt
ss -tuln >> evidence/detection_results.txt

echo "" >> evidence/detection_results.txt
echo "=== Process Analysis ===" >> evidence/detection_results.txt
ps aux | grep -v grep | grep -E "(yes|suspicious|malware)" >> evidence/detection_results.txt

echo "" >> evidence/detection_results.txt
echo "=== Recent File Changes ===" >> evidence/detection_results.txt
find /tmp -type f -mmin -10 >> evidence/detection_results.txt

cat evidence/detection_results.txt

cat evidence/timeline/detection_timeline.txt


# ==============================
# Containment Phase
# ==============================

./scripts/containment_actions.sh

ps aux | grep yes
ls evidence/quarantine/

cat logs/system/containment_*.log


# ==============================
# Evidence Preservation
# ==============================

./scripts/preserve_evidence.sh
ls evidence/volatile/


# ==============================
# Recovery Phase
# ==============================

./scripts/recovery_verification.sh
cat logs/system/recovery_*.log

./scripts/system_hardening.sh
cat logs/system/hardening_*.log

./scripts/final_validation.sh
cat logs/system/final_validation_*.log
