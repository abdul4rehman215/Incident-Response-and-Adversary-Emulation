#!/bin/bash

DUMP="$1"

if [ -z "$DUMP" ]; then
    echo "Usage: $0 <memory-dump>"
    exit 1
fi

echo "ADVANCED ROOTKIT DETECTION"
echo "=========================="
echo "Memory Dump: $DUMP"
echo

PSLIST=$(vol3 -f "$DUMP" linux.pslist | wc -l)
PSTREE=$(vol3 -f "$DUMP" linux.pstree | wc -l)

echo "Process Count PSList: $PSLIST"
echo "Process Count PSTree: $PSTREE"

if [ "$PSLIST" -ne "$PSTREE" ]; then
    echo "WARNING: Possible hidden processes"
fi

echo
echo "Suspicious Kernel Modules:"
vol3 -f "$DUMP" linux.lsmod | grep -v -E "(ext4|usb|input|sound|net|crypto|overlay)"

echo
echo "Suspicious Network Connections:"
vol3 -f "$DUMP" linux.netstat | grep -v -E "(22|80|443)"

echo
echo "Deleted or Hidden File Handles:"
vol3 -f "$DUMP" linux.lsof | grep deleted

echo
echo "Rootkit detection complete."
