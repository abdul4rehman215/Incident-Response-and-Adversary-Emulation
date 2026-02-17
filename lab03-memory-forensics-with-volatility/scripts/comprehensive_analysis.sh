#!/bin/bash

DUMP_FILE="$1"
OUTPUT_DIR="analysis-results"

if [ -z "$DUMP_FILE" ]; then
    echo "Usage: $0 <memory-dump-file>"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

echo "Starting comprehensive memory analysis..."

echo "1. System Banner"
vol3 -f "$DUMP_FILE" linux.banner > "$OUTPUT_DIR/01-system-info.txt"

echo "2. Process Listing"
vol3 -f "$DUMP_FILE" linux.pslist > "$OUTPUT_DIR/02-process-list.txt"

echo "3. Process Tree"
vol3 -f "$DUMP_FILE" linux.pstree > "$OUTPUT_DIR/03-process-tree.txt"

echo "4. Network Connections"
vol3 -f "$DUMP_FILE" linux.netstat > "$OUTPUT_DIR/04-network-connections.txt"

echo "5. Loaded Modules"
vol3 -f "$DUMP_FILE" linux.lsmod > "$OUTPUT_DIR/05-loaded-modules.txt"

echo "6. Open Files"
vol3 -f "$DUMP_FILE" linux.lsof > "$OUTPUT_DIR/06-open-files.txt"

echo "7. Suspicious Strings"
strings "$DUMP_FILE" | grep -E "(http|ftp|password|admin|root)" | head -100 > "$OUTPUT_DIR/07-suspicious-strings.txt"

echo "8. Summary Report"

TOTAL_PROCESSES=$(wc -l < "$OUTPUT_DIR/02-process-list.txt")
TOTAL_CONNECTIONS=$(wc -l < "$OUTPUT_DIR/04-network-connections.txt")
TOTAL_MODULES=$(wc -l < "$OUTPUT_DIR/05-loaded-modules.txt")
TOTAL_OPENFILES=$(wc -l < "$OUTPUT_DIR/06-open-files.txt")
PYTHON_COUNT=$(grep -c python "$OUTPUT_DIR/02-process-list.txt")
LISTEN_COUNT=$(grep -c LISTEN "$OUTPUT_DIR/04-network-connections.txt")

nano "$OUTPUT_DIR/00-analysis-summary.txt"
