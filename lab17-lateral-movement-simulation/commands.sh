#!/bin/bash
# Lab 17 – Lateral Movement and Pivoting (Safe Simulation Version)
# Commands Executed During Lab

# ======================================
# Task 1 – Environment Preparation
# ======================================

sudo apt update && sudo apt upgrade -y

sudo apt install -y python3 python3-pip net-tools tcpdump openssh-server curl

sudo systemctl enable ssh
sudo systemctl start ssh
sudo systemctl status ssh

mkdir -p ~/lab17-simulation/{c2,agents,pivot,scripts,logs,network}
cd ~/lab17-simulation
ls -la

# ======================================
# Task 2 – Build Simulated C2 Server
# ======================================

nano c2/simulated_c2.py
chmod +x c2/simulated_c2.py

cd c2
python3 simulated_c2.py
# (Left running in terminal)

# ======================================
# Task 3 – Create Simulated Beacon Agent
# ======================================

cd ~/lab17-simulation
nano agents/beacon_agent.py

pip3 install requests
chmod +x agents/beacon_agent.py

python3 agents/beacon_agent.py
# (Running in separate terminal)

# ======================================
# Task 4 – Simulate Lateral Movement
# ======================================

sudo adduser pivotuser

ssh pivotuser@localhost
whoami
exit

# ======================================
# Task 5 – Simulate Pivoting (Port Forwarding)
# ======================================

ssh -L 9090:localhost:8080 pivotuser@localhost

curl http://localhost:9090

# ======================================
# Task 6 – Network Mapping
# ======================================

ip a
netstat -tulpn

# ======================================
# Task 7 – Traffic Analysis
# ======================================

sudo tcpdump -i lo -A port 8080

# ======================================
# Task 8 – Simulate Persistence
# ======================================

nano scripts/persistence_sim.sh
chmod +x scripts/persistence_sim.sh
bash scripts/persistence_sim.sh

source ~/.bashrc
ps aux | grep beacon_agent

# ======================================
# Task 9 – Detection Script
# ======================================

nano scripts/detection_test.sh
chmod +x scripts/detection_test.sh
bash scripts/detection_test.sh

# ======================================
# Cleanup Commands (Post-Lab)
# ======================================

pkill -f beacon_agent.py
pkill -f simulated_c2.py
rm -rf ~/lab17-simulation
