#!/bin/bash

############################################################
# performance_test.sh
# Lab 11: Password Cracking with Hashcat
# Purpose: Compare CPU vs GPU cracking performance
############################################################

echo "=============================================="
echo "        Performance Comparison Test"
echo "=============================================="
echo "Date: $(date)"
echo "System: $(hostname)"
echo ""

echo "Testing MD5 hash cracking performance"
echo ""

# CPU-only test (Device 1 typically CPU)
echo "----------------------------------------------"
echo "CPU-only test:"
echo "----------------------------------------------"

time hashcat -m 0 -a 0 -d 1 --quiet md5_hashes.txt wordlists/top1m.txt 2>/dev/null

echo ""

# GPU test (Device 2 typically GPU)
echo "----------------------------------------------"
echo "GPU-accelerated test:"
echo "----------------------------------------------"

time hashcat -m 0 -a 0 -d 2 --quiet md5_hashes.txt wordlists/top1m.txt 2>/dev/null

echo ""
echo "=============================================="
echo "Performance test completed"
echo "=============================================="
