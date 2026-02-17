# ================================
# LAB 03 — Memory Forensics with Volatility
# Full Chronological Command Log
# ================================

# -------------------------------
# Task 1 — Environment Setup
# -------------------------------

sudo apt update

sudo apt install -y \
python3 \
python3-pip \
git \
build-essential \
python3-dev \
libssl-dev \
linux-headers-$(uname -r) \
volatility \
volatility-tools \
netcat-openbsd \
strings


# -------------------------------
# Install Volatility 3
# -------------------------------

mkdir -p ~/forensics-tools
cd ~/forensics-tools

git clone https://github.com/volatilityfoundation/volatility3.git

cd volatility3
pip3 install -r requirements.txt

chmod +x vol.py
sudo ln -sf "$(pwd)/vol.py" /usr/local/bin/vol3


# -------------------------------
# Verify Installation
# -------------------------------

volatility --info | head
vol3 --help | head
python3 --version


# -------------------------------
# Task 2 — Create Suspicious Activity
# -------------------------------

mkdir -p ~/memory-forensics-lab
cd ~/memory-forensics-lab

python3 -m http.server 8080 &
nc -lvnp 9999 &

nano suspicious_script.py
chmod +x suspicious_script.py
python3 suspicious_script.py &

jobs -l


# -------------------------------
# Install LiME
# -------------------------------

cd ~/forensics-tools
git clone https://github.com/504ensicsLabs/LiME.git

cd LiME/src
make

ls -lh lime-*.ko


# -------------------------------
# Create Memory Dump
# -------------------------------

mkdir -p ~/memory-dumps
cd ~/memory-dumps

sudo insmod ~/forensics-tools/LiME/src/lime-6.8.0-31-generic.ko "path=$(pwd)/memory-dump.lime format=lime"

watch -n 2 ls -lh memory-dump.lime

sudo rmmod lime


# -------------------------------
# Alternative Dump Method
# -------------------------------

sudo dd if=/proc/kcore of=memory-dump.dd bs=1M count=512


# -------------------------------
# Task 3 — Basic Memory Analysis
# -------------------------------

cd ~/memory-dumps

volatility -f memory-dump.lime imageinfo

vol3 -f memory-dump.lime linux.banner

vol3 -f memory-dump.lime linux.pslist
vol3 -f memory-dump.lime linux.pstree

vol3 -f memory-dump.lime linux.pslist > process-list.txt

vol3 -f memory-dump.lime linux.netstat
vol3 -f memory-dump.lime linux.netstat > network-connections.txt

grep -E "(8080|9999|python)" network-connections.txt

vol3 -f memory-dump.lime linux.lsmod
vol3 -f memory-dump.lime linux.lsmod > loaded-modules.txt

grep -v -E "(ext4|usb|input|sound|net|crypto|overlay)" loaded-modules.txt


# -------------------------------
# Advanced Analysis
# -------------------------------

vol3 -f memory-dump.lime linux.pslist > detailed-processes.txt

vol3 -f memory-dump.lime linux.pslist | grep -E "(/tmp|/var/tmp|/dev/shm)"
vol3 -f memory-dump.lime linux.pslist | awk '$4 == 0 && $3 != 0'
vol3 -f memory-dump.lime linux.pslist | grep python

strings memory-dump.lime > memory-strings.txt

grep -i -E "(http://|https://|ftp://)" memory-strings.txt | head -20
grep -i -E "(metasploit|meterpreter|payload|exploit)" memory-strings.txt
grep -E "(/tmp/\.|/var/tmp/\.|\.sh|\.py)" memory-strings.txt | head -10
grep -A5 -B5 "suspicious_activity" memory-strings.txt

vol3 -f memory-dump.lime linux.lsof > open-files.txt
grep -E "(passwd|shadow|sudoers)" open-files.txt
grep -E "(/tmp|/var/tmp|/dev/shm)" open-files.txt


# -------------------------------
# Rootkit Detection
# -------------------------------

nano rootkit_detection.sh
chmod +x rootkit_detection.sh
./rootkit_detection.sh memory-dump.lime > rootkit-analysis.txt


# -------------------------------
# Process Memory Dumping
# -------------------------------

vol3 -f memory-dump.lime linux.pslist | grep python
PYTHON_PID=3148

vol3 -f memory-dump.lime linux.proc.Maps --pid $PYTHON_PID > process-3148-maps.txt

mkdir -p process-dumps
vol3 -f memory-dump.lime linux.proc.Dump --pid $PYTHON_PID --dump-dir process-dumps/

mkdir -p extracted-files
vol3 -f memory-dump.lime linux.elfs --dump-dir extracted-files/

ls -lh extracted-files/

for file in extracted-files/*; do
echo "File: $file"
file "$file"
echo "-------------------------"
done


# -------------------------------
# Timeline Reconstruction
# -------------------------------

nano timeline-analysis.txt

vol3 -f memory-dump.lime linux.pslist | sort -k5 >> timeline-analysis.txt
echo "" >> timeline-analysis.txt
echo "=== PROCESS TREE ===" >> timeline-analysis.txt
vol3 -f memory-dump.lime linux.pstree >> timeline-analysis.txt

head -30 timeline-analysis.txt


# -------------------------------
# Comprehensive Analysis Script
# -------------------------------

nano comprehensive_analysis.sh
chmod +x comprehensive_analysis.sh
./comprehensive_analysis.sh memory-dump.lime


# -------------------------------
# Advanced Rootkit Detection
# -------------------------------

nano advanced_rootkit_detection.sh
chmod +x advanced_rootkit_detection.sh
./advanced_rootkit_detection.sh memory-dump.lime > advanced-rootkit-analysis.txt


# -------------------------------
# Signature Detection
# -------------------------------

nano signature_detection.sh
chmod +x signature_detection.sh
./signature_detection.sh memory-dump.lime > signature-analysis.txt


# -------------------------------
# Final Report Generation
# -------------------------------

nano generate_final_report.sh
chmod +x generate_final_report.sh
./generate_final_report.sh memory-dump.lime

ls FORENSIC_REPORT_*.txt
head -30 FORENSIC_REPORT_LAB-MF-20260217.txt


# -------------------------------
# Archive Results
# -------------------------------

mkdir -p final-results

cp -r analysis-results final-results/
cp *.txt final-results/ 2>/dev/null
cp FORENSIC_REPORT_*.txt final-results/

tar -czf memory-forensics-analysis-$(date +%Y%m%d).tar.gz final-results/

ls -lh final-results/
ls -lh memory-forensics-analysis-*.tar.gz
find final-results/ -type f | wc -l
