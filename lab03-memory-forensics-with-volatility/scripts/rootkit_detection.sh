#!/bin/bash

DUMP="$1"

if [ -z "$DUMP" ]; then
    echo "Usage: $0 <memory-dump>"
    exit 1
fi

echo "=== ROOTKIT DETECTION ANALYSIS ==="
echo "Memory Dump: $DUMP"
echo "Date: $(date)"
echo

echo "1. Process Count Comparison:"
PSLIST=$(vol3 -f "$DUMP" linux.pslist | wc -l)
PSTREE=$(vol3 -f "$DUMP" linux.pstree | wc -l)
echo "PSList Count: $PSLIST"
echo "PSTree Count: $PSTREE"

echo
echo "2. Suspicious Kernel Modules:"
vol3 -f "$DUMP" linux.lsmod | grep -v -E "(ext4|usb|input|sound|net|crypto|overlay)"

echo
echo "3. Suspicious Network Connections:"
vol3 -f "$DUMP" linux.netstat | grep -E "(LISTEN|ESTABLISHED)" | grep -v -E "(22|80|443)"

echo
echo "4. Hidden/Deleted File Handles:"
vol3 -f "$DUMP" linux.lsof | grep -E "(deleted|UNKNOWN)"

echo
echo "=== ROOTKIT CHECK COMPLETE ==="
