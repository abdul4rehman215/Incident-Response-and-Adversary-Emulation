#!/bin/bash

###############################################
# Lab 11: Password Cracking with Hashcat
# Al Razzaq – Incident Response & Adversary Emulation
###############################################

################################################
# TASK 1 – Environment Setup
################################################

# Update system
sudo apt update && sudo apt upgrade -y

# Install Hashcat and OpenCL dependencies
sudo apt install hashcat opencl-headers ocl-icd-opencl-dev -y

# Install NVIDIA drivers (GPU instance)
sudo apt install nvidia-driver-470 nvidia-opencl-dev -y

# Verify Hashcat installation
hashcat --version

# Check OpenCL devices (GPU + CPU)
hashcat -I

################################################
# TASK 2 – Create Working Directory
################################################

mkdir ~/hashcat_lab
cd ~/hashcat_lab

################################################
# TASK 3 – Generate Sample Hash Files
################################################

# MD5 hashes
echo -n "password123" | md5sum | cut -d' ' -f1 > md5_hashes.txt
echo -n "admin2023" | md5sum | cut -d' ' -f1 >> md5_hashes.txt
echo -n "welcome" | md5sum | cut -d' ' -f1 >> md5_hashes.txt
echo -n "qwerty" | md5sum | cut -d' ' -f1 >> md5_hashes.txt

# SHA-256 hashes
echo -n "password123" | sha256sum | cut -d' ' -f1 > sha256_hashes.txt
echo -n "admin2023" | sha256sum | cut -d' ' -f1 >> sha256_hashes.txt
echo -n "welcome" | sha256sum | cut -d' ' -f1 >> sha256_hashes.txt
echo -n "qwerty" | sha256sum | cut -d' ' -f1 >> sha256_hashes.txt

cat md5_hashes.txt
cat sha256_hashes.txt

################################################
# TASK 4 – Prepare Wordlists
################################################

mkdir wordlists
cd wordlists

# Download top wordlist
wget https://github.com/danielmiessler/SecLists/raw/master/Passwords/Common-Credentials/10-millionpassword-list-top-1000000.txt -O top1m.txt

# Custom wordlist
cat > custom_wordlist.txt << 'EOF'
password
123456
password123
admin
admin2023
welcome
qwerty
letmein
monkey
dragon
EOF

# Numeric wordlist
seq 1000 9999 > numeric.txt

cd ~/hashcat_lab

################################################
# TASK 5 – Dictionary Attack (MD5)
################################################

hashcat -m 0 -a 0 md5_hashes.txt wordlists/custom_wordlist.txt

hashcat -m 0 md5_hashes.txt --show > md5_cracked.txt
cat md5_cracked.txt

################################################
# TASK 6 – Dictionary Attack (SHA-256)
################################################

hashcat -m 1400 -a 0 sha256_hashes.txt wordlists/custom_wordlist.txt

hashcat -m 1400 sha256_hashes.txt --show > sha256_cracked.txt
cat sha256_cracked.txt

################################################
# TASK 7 – Performance Comparison (CPU vs GPU)
################################################

nano performance_test.sh

chmod +x performance_test.sh
./performance_test.sh

################################################
# TASK 8 – Brute Force Attacks
################################################

# Create simple test hashes
echo -n "abc" | md5sum | cut -d' ' -f1 > simple_md5.txt
echo -n "123" | md5sum | cut -d' ' -f1 >> simple_md5.txt

# Lowercase brute force
hashcat -m 0 -a 3 simple_md5.txt ?l?l?l

# Numeric brute force
hashcat -m 0 -a 3 simple_md5.txt ?d?d?d

hashcat -m 0 simple_md5.txt --show

################################################
# TASK 9 – Rule-Based Attack
################################################

nano custom.rule

hashcat -m 0 -a 0 md5_hashes.txt wordlists/custom_wordlist.txt -r custom.rule

################################################
# TASK 10 – Combination Attack
################################################

echo -e "pass\nadmin\nuser" > left.txt
echo -e "word\n123\n2023" > right.txt

echo -n "password" | md5sum | cut -d' ' -f1 > combo_test.txt
echo -n "admin123" | md5sum | cut -d' ' -f1 >> combo_test.txt
echo -n "user2023" | md5sum | cut -d' ' -f1 >> combo_test.txt

hashcat -m 0 -a 1 combo_test.txt left.txt right.txt

################################################
# TASK 11 – Benchmark Testing
################################################

nano benchmark.sh
chmod +x benchmark.sh
./benchmark.sh > benchmark_results.txt
cat benchmark_results.txt

################################################
# TASK 12 – Optimized Cracking
################################################

nano optimized_crack.sh
chmod +x optimized_crack.sh

./optimized_crack.sh md5_hashes.txt wordlists/top1m.txt 0

################################################
# TASK 13 – Reporting
################################################

nano analysis_report.sh
chmod +x analysis_report.sh

./analysis_report.sh > final_report.txt
cat final_report.txt

################################################
# TASK 14 – Metrics Collection
################################################

nano metrics.sh
chmod +x metrics.sh
./metrics.sh

################################################
# TASK 15 – Lab Validation
################################################

nano validate_lab.sh
chmod +x validate_lab.sh
./validate_lab.sh

################################################
# END OF LAB 11
################################################
