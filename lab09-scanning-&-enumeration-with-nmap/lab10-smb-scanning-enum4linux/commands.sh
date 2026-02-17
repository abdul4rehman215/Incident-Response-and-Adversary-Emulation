#!/bin/bash
# =========================================================
# Lab 10: SMB Scanning with Enum4Linux
# Complete Command Execution Log
# Environment: Ubuntu 24.04.1 LTS
# Host: toor@ip-172-31-10-241
# =========================================================


# ---------------------------------------------------------
# 1️⃣ Verify Enum4Linux Installation
# ---------------------------------------------------------

enum4linux --help


# ---------------------------------------------------------
# 2️⃣ Install and Configure Samba (Local SMB Lab Setup)
# ---------------------------------------------------------

sudo apt update
sudo apt install samba samba-common-bin -y

# Create SMB share directory
sudo mkdir -p /srv/samba/testshare
sudo chmod 755 /srv/samba/testshare
ls -ld /srv/samba/testshare

# Create test users
sudo useradd -m testuser1
sudo useradd -m testuser2

# Set system passwords
echo "testuser1:password123" | sudo chpasswd
echo "testuser2:password456" | sudo chpasswd

# Add users to Samba
echo -e "password123\npassword123" | sudo smbpasswd -a testuser1
echo -e "password456\npassword456" | sudo smbpasswd -a testuser2

# Configure Samba
sudo nano /etc/samba/smb.conf

# Validate configuration
sudo testparm

# Restart and enable Samba
sudo systemctl restart smbd
sudo systemctl enable smbd
sudo systemctl status smbd


# ---------------------------------------------------------
# 3️⃣ Basic SMB Enumeration
# ---------------------------------------------------------

enum4linux -a 127.0.0.1

# Targeted enumeration
enum4linux -U 127.0.0.1
enum4linux -G 127.0.0.1
enum4linux -S 127.0.0.1
enum4linux -P 127.0.0.1
enum4linux -r 127.0.0.1
enum4linux -o 127.0.0.1


# ---------------------------------------------------------
# 4️⃣ Create Comprehensive Bash Enumeration Script
# ---------------------------------------------------------

nano SMB_enum_comprehensive.sh
chmod +x SMB_enum_comprehensive.sh

# Run comprehensive script
./SMB_enum_comprehensive.sh 127.0.0.1

# Verify output directory
ls smb_enum_*
ls smb_enum_*/


# ---------------------------------------------------------
# 5️⃣ Analyze Enumeration Results (Python Script)
# ---------------------------------------------------------

nano analyze_smb_results.py
chmod +x analyze_smb_results.py

# Run analysis
python3 analyze_smb_results.py smb_enum_20260217_191530


# ---------------------------------------------------------
# 6️⃣ Create SMB Network Scanner (Multi-Threaded)
# ---------------------------------------------------------

nano smb_network_scanner.py
chmod +x smb_network_scanner.py

# Create target list
cat > targets.txt << 'EOF'
127.0.0.1
EOF

cat targets.txt

# Scan single target
python3 smb_network_scanner.py 127.0.0.1

# Scan using file input
python3 smb_network_scanner.py targets.txt

# View report
cat smb_scan_report.txt


# ---------------------------------------------------------
# 7️⃣ Advanced SMB Analyzer
# ---------------------------------------------------------

nano advanced_smb_analyzer.py
chmod +x advanced_smb_analyzer.py

# Run advanced analyzer
python3 advanced_smb_analyzer.py 127.0.0.1

# View reports
cat smb_summary_report.txt
cat detailed_smb_report.json


# ---------------------------------------------------------
# 8️⃣ Verification & Testing
# ---------------------------------------------------------

# Verify Enum4Linux
enum4linux --help | head -5

# Verify Python modules
python3 -c "import subprocess, threading, json; print('All modules available')"

# Verify Samba service
sudo systemctl status smbd

# Basic enumeration test
enum4linux -U 127.0.0.1 | grep -i user


# =========================================================
# End of Lab 10 Command Execution
# =========================================================
