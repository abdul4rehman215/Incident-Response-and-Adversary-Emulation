#!/bin/bash

# =========================================
# Simple Nmap Results Analyzer
# Lab 9 – Scanning & Enumeration with Nmap
# =========================================

if [ $# -eq 0 ]; then
    echo "Usage: $0 <results_directory>"
    echo "Example: $0 nmap_results_20260217_181245"
    exit 1
fi

RESULTS_DIR="$1"

if [ ! -d "$RESULTS_DIR" ]; then
    echo "Error: Directory '$RESULTS_DIR' does not exist."
    exit 1
fi

echo "========================================="
echo " NMAP RESULTS ANALYSIS"
echo "========================================="
echo ""

#############################################
# Count Open Ports
#############################################

OPEN_PORTS=$(find "$RESULTS_DIR" -name "*.txt" -exec grep -h "open" {} \; | wc -l)

echo "Total open ports found: $OPEN_PORTS"
echo ""

#############################################
# List Unique Services
#############################################

echo "Services discovered:"
echo "==================="

find "$RESULTS_DIR" -name "*.txt" -exec grep -h "open" {} \; \
| awk '{print $3}' \
| sort \
| uniq

echo ""

#############################################
# Identify Potential Security Concerns
#############################################

echo "Potential security concerns:"
echo "============================"

find "$RESULTS_DIR" -name "*.txt" -exec grep -i -H "vulnerable\|exploit\|weak" {} \;

echo ""

#############################################
# Port Distribution Summary
#############################################

echo "Port Distribution:"
echo "=================="

find "$RESULTS_DIR" -name "*.txt" -exec grep -h "open" {} \; \
| awk '{print $1}' \
| sort \
| uniq -c \
| sort -nr

echo ""

#############################################
# Generate Lightweight Summary File
#############################################

SUMMARY_FILE="$RESULTS_DIR/analysis_summary.txt"

echo "=========================================" > "$SUMMARY_FILE"
echo " NMAP ANALYSIS SUMMARY REPORT" >> "$SUMMARY_FILE"
echo "=========================================" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"

echo "Analysis Date: $(date)" >> "$SUMMARY_FILE"
echo "Target Directory: $RESULTS_DIR" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"

echo "Total Open Ports: $OPEN_PORTS" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"

echo "Services Identified:" >> "$SUMMARY_FILE"
find "$RESULTS_DIR" -name "*.txt" -exec grep -h "open" {} \; \
| awk '{print $3}' \
| sort \
| uniq >> "$SUMMARY_FILE"

echo "" >> "$SUMMARY_FILE"

echo "Potential Security Indicators:" >> "$SUMMARY_FILE"
find "$RESULTS_DIR" -name "*.txt" -exec grep -i -H "vulnerable\|exploit\|weak" {} \; >> "$SUMMARY_FILE"

echo "" >> "$SUMMARY_FILE"
echo "=========================================" >> "$SUMMARY_FILE"
echo " End of Report" >> "$SUMMARY_FILE"
echo "=========================================" >> "$SUMMARY_FILE"

echo "[✓] Analysis summary generated: $SUMMARY_FILE"
echo ""
echo "Analysis complete."
