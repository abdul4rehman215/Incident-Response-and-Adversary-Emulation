#!/bin/bash

############################################################
# metrics.sh
# Lab 11: Performance Metrics Collection
############################################################

echo "=============================================="
echo "        Performance Metrics Collection"
echo "=============================================="
echo "Date: $(date)"
echo ""

# Create test hash
echo -n "testpassword" | md5sum | cut -d' ' -f1 > test_hash.txt

echo "Testing different attack modes on MD5:"
echo ""

echo "------------------------------------------------"
echo "1. Dictionary Attack Performance:"
echo "------------------------------------------------"
time hashcat -m 0 -a 0 test_hash.txt wordlists/custom_wordlist.txt --quiet 2>/dev/null

echo ""
echo "------------------------------------------------"
echo "2. Brute Force Attack Performance (4 chars):"
echo "------------------------------------------------"
time hashcat -m 0 -a 3 test_hash.txt ?l?l?l?l --quiet 2>/dev/null

echo ""
echo "------------------------------------------------"
echo "3. Rule-based Attack Performance:"
echo "------------------------------------------------"
time hashcat -m 0 -a 0 test_hash.txt wordlists/custom_wordlist.txt -r custom.rule --quiet 2>/dev/null

echo ""
echo "------------------------------------------------"
echo "Hardware Utilization During Cracking"
echo "------------------------------------------------"

echo ""
echo "GPU Status:"
nvidia-smi 2>/dev/null || echo "NVIDIA GPU not available"

echo ""
echo "System Load:"
uptime

echo ""
echo "=============================================="
echo "Metrics collection completed"
echo "=============================================="
