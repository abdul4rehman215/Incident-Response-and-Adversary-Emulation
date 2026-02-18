#!/bin/bash
# Lab 18 – C2 Evasion Techniques (Safe Simulation Version)
# Commands Executed During Lab

# =====================================
# Task 1 – Prepare Environment
# =====================================

sudo apt update && sudo apt upgrade -y

sudo apt install -y python3 python3-pip curl net-tools tcpdump

mkdir -p ~/c2-simulation/{server,implant,scripts,logs}
cd ~/c2-simulation
ls -la

# =====================================
# Task 2 – Create Simulated C2 Server
# =====================================

nano server/c2_server.py
chmod +x server/c2_server.py

cd server
python3 c2_server.py
# (Server running in terminal)

# =====================================
# Task 3 – Create Simulated Implant
# =====================================

cd ~/c2-simulation
nano implant/beacon.py

pip3 install requests

chmod +x implant/beacon.py

cd implant
python3 beacon.py
# (Running in separate terminal)

# =====================================
# Task 4 – Network Traffic Analysis
# =====================================

sudo tcpdump -i lo -A -s 0 port 8080

# =====================================
# Task 5 – Persistence Simulation
# =====================================

nano scripts/persistence.sh
chmod +x scripts/persistence.sh
bash scripts/persistence.sh

source ~/.bashrc
ps aux | grep beacon.py

# =====================================
# Task 6 – Domain Fronting Simulation
# =====================================

nano scripts/domain_fronting.sh
chmod +x scripts/domain_fronting.sh
bash scripts/domain_fronting.sh

# =====================================
# Task 7 – Detection Testing
# =====================================

nano scripts/detection_test.sh
chmod +x scripts/detection_test.sh
bash scripts/detection_test.sh

# =====================================
# Optional Cleanup (Post-Lab)
# =====================================

pkill -f beacon.py
pkill -f c2_server.py
rm -rf ~/c2-simulation
