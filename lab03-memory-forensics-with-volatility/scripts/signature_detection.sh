#!/bin/bash

DUMP="$1"

if [ -z "$DUMP" ]; then
    echo "Usage: $0 <memory-dump>"
    exit 1
fi

echo "MEMORY SIGNATURE ANALYSIS"
echo "========================"

strings "$DUMP" > temp_strings.txt

SIGNATURES=(
"meterpreter"
"metasploit"
"payload"
"shellcode"
"backdoor"
"rootkit"
"keylogger"
"botnet"
"trojan"
"ransomware"
)

for sig in "${SIGNATURES[@]}"; do
    COUNT=$(grep -ci "$sig" temp_strings.txt)
    if [ "$COUNT" -gt 0 ]; then
        echo "FOUND: $sig ($COUNT matches)"
    else
        echo "Not found: $sig"
    fi
done

rm temp_strings.txt

echo "Signature analysis complete."
