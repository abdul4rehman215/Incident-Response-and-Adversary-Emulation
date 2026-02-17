#!/bin/bash

############################################################
# validate_lab.sh
# Lab 11: Environment Validation Script
############################################################

echo "=============================================="
echo "        Lab 11 Validation Checklist"
echo "=============================================="
echo ""

# Check Hashcat installation
if command -v hashcat &> /dev/null; then
    echo "✓ Hashcat installed successfully"
    hashcat --version
else
    echo "✗ Hashcat not found"
fi

echo ""

# Check hash files
if [ -f md5_hashes.txt ]; then
    echo "✓ MD5 hash file created"
else
    echo "✗ MD5 hash file missing"
fi

if [ -f sha256_hashes.txt ]; then
    echo "✓ SHA-256 hash file created"
else
    echo "✗ SHA-256 hash file missing"
fi

echo ""

# Check wordlists
if [ -f wordlists/custom_wordlist.txt ]; then
    echo "✓ Custom wordlist created"
else
    echo "✗ Custom wordlist missing"
fi

echo ""

# Check cracked results
if [ -f md5_cracked.txt ] && [ -s md5_cracked.txt ]; then
    echo "✓ MD5 passwords successfully cracked"
else
    echo "✗ No MD5 passwords cracked"
fi

if [ -f sha256_cracked.txt ] && [ -s sha256_cracked.txt ]; then
    echo "✓ SHA-256 passwords successfully cracked"
else
    echo "✗ No SHA-256 passwords cracked"
fi

echo ""

# Check OpenCL devices
if hashcat -I | grep -q "OpenCL"; then
    echo "✓ OpenCL devices detected"
else
    echo "✗ No OpenCL devices found"
fi

echo ""
echo "=============================================="
echo "Validation completed"
echo "=============================================="
