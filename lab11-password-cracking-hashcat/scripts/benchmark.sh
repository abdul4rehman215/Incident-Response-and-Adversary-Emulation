#!/bin/bash

############################################################
# benchmark.sh
# Lab 11: Hashcat Benchmark Analysis
# Purpose: Benchmark different hash algorithms
############################################################

echo "=============================================="
echo "        Hashcat Benchmark Analysis"
echo "=============================================="
echo "Date: $(date)"
echo ""

echo "----------------------------------------------"
echo "Benchmarking MD5 (Hash mode 0):"
echo "----------------------------------------------"
hashcat -b -m 0

echo ""
echo "----------------------------------------------"
echo "Benchmarking SHA-256 (Hash mode 1400):"
echo "----------------------------------------------"
hashcat -b -m 1400

echo ""
echo "----------------------------------------------"
echo "Benchmarking NTLM (Hash mode 1000):"
echo "----------------------------------------------"
hashcat -b -m 1000

echo ""
echo "----------------------------------------------"
echo "Benchmarking bcrypt (Hash mode 3200):"
echo "----------------------------------------------"
hashcat -b -m 3200

echo ""
echo "----------------------------------------------"
echo "System Information"
echo "----------------------------------------------"

echo "GPU Information:"
lspci | grep -i vga

echo ""
echo "CPU Information:"
lscpu | grep "Model name"

echo ""
echo "Memory Information:"
free -h

echo ""
echo "=============================================="
echo "Benchmark completed"
echo "=============================================="
