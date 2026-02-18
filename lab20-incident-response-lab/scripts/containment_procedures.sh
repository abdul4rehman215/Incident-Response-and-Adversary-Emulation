#!/bin/bash

echo "=== CONTAINMENT PROCEDURES ==="
echo "Implementing immediate containment measures..."
echo

# Network containment
echo "1. Implementing network containment..."

sudo iptables -A INPUT -s 192.168.1.100 -j DROP
sudo iptables -A OUTPUT -d 192.168.1.100 -j DROP

sudo iptables -A INPUT -p tcp --dport 4444 -j DROP
sudo iptables -A INPUT -p tcp --dport 1337 -j DROP

sudo iptables -A INPUT -j LOG --log-prefix "BLOCKED: "

echo "Network containment rules applied"
echo

# Process containment
echo "2. Implementing process containment..."

pkill -f "suspicious"
pkill -f "malware"

sudo systemctl stop telnet 2>/dev/null
sudo systemctl disable telnet 2>/dev/null

echo "Process containment completed"
echo

# File system containment
echo "3. Implementing file system containment..."

sudo mkdir -p /quarantine
sudo mv /tmp/malware_test/* /quarantine/ 2>/dev/null

sudo chattr +i /etc/passwd
sudo chattr +i /etc/shadow

echo "File system containment completed"
echo

# User account containment
echo "4. Implementing user account containment..."

# Example (commented for safety)
# sudo usermod -L suspicious_user
# sudo chage -d 0 username

echo "User account containment completed"
echo
echo "=== CONTAINMENT PHASE COMPLETE ==="
