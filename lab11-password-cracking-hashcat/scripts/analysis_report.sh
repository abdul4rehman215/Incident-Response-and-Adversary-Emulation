#!/bin/bash

############################################################
# analysis_report.sh
# Lab 11: Password Cracking Analysis Report Generator
############################################################

echo "=============================================="
echo "      Password Cracking Analysis Report"
echo "=============================================="
echo "Generated on: $(date)"
echo "Analyst: $(whoami)"
echo ""

echo "############################################################"
echo "## HASH ANALYSIS SUMMARY"
echo "############################################################"
echo ""

# MD5 Analysis
echo "### MD5 Hashes Analyzed:"
if [ -f md5_hashes.txt ]; then
    wc -l md5_hashes.txt
else
    echo "md5_hashes.txt not found"
fi

echo ""
echo "Cracked:"
if [ -f md5_cracked.txt ]; then
    wc -l md5_cracked.txt
    TOTAL=$(wc -l < md5_hashes.txt)
    CRACKED=$(wc -l < md5_cracked.txt)
    echo "Success Rate: $(echo "scale=2; $CRACKED * 100 / $TOTAL" | bc)%"
else
    echo "0"
fi

echo ""
echo "------------------------------------------------------------"

# SHA-256 Analysis
echo "### SHA-256 Hashes Analyzed:"
if [ -f sha256_hashes.txt ]; then
    wc -l sha256_hashes.txt
else
    echo "sha256_hashes.txt not found"
fi

echo ""
echo "Cracked:"
if [ -f sha256_cracked.txt ]; then
    wc -l sha256_cracked.txt
    TOTAL_SHA=$(wc -l < sha256_hashes.txt)
    CRACKED_SHA=$(wc -l < sha256_cracked.txt)
    echo "Success Rate: $(echo "scale=2; $CRACKED_SHA * 100 / $TOTAL_SHA" | bc)%"
else
    echo "0"
fi

echo ""
echo "############################################################"
echo "## CRACKED PASSWORDS ANALYSIS"
echo "############################################################"
echo ""

if [ -f md5_cracked.txt ]; then
    echo "### MD5 Cracked Passwords:"
    cat md5_cracked.txt | cut -d':' -f2 | sort | uniq -c | sort -nr
    echo ""
fi

if [ -f sha256_cracked.txt ]; then
    echo "### SHA-256 Cracked Passwords:"
    cat sha256_cracked.txt | cut -d':' -f2 | sort | uniq -c | sort -nr
    echo ""
fi

echo "############################################################"
echo "## SECURITY RECOMMENDATIONS"
echo "############################################################"
echo ""
echo "1. Avoid common passwords found in public wordlists."
echo "2. Enforce strong password complexity policies."
echo "3. Use salted hashes."
echo "4. Prefer modern KDFs such as bcrypt or Argon2."
echo "5. Implement account lockout mechanisms."
echo ""

echo "=============================================="
echo "Report generation completed"
echo "=============================================="
