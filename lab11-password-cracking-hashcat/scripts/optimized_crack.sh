#!/bin/bash

############################################################
# optimized_crack.sh
# Lab 11: Optimized Hashcat Cracking
############################################################

HASH_FILE="$1"
WORDLIST="$2"
HASH_MODE="$3"

if [ $# -ne 3 ]; then
    echo "Usage: $0 <hash_file> <wordlist> <hash_mode>"
    echo "Example: $0 md5_hashes.txt wordlists/top1m.txt 0"
    exit 1
fi

echo "=============================================="
echo "        Optimized Hashcat Cracking"
echo "=============================================="
echo "Hash file  : $HASH_FILE"
echo "Wordlist   : $WORDLIST"
echo "Hash mode  : $HASH_MODE"
echo "Date       : $(date)"
echo ""

hashcat -m "$HASH_MODE" -a 0 "$HASH_FILE" "$WORDLIST" \
    --optimized-kernel-enable \
    --workload-profile 3 \
    --status \
    --status-timer 10

echo ""
echo "----------------------------------------------"
echo "Cracked Results:"
echo "----------------------------------------------"

hashcat -m "$HASH_MODE" "$HASH_FILE" --show

echo ""
echo "=============================================="
echo "Optimized cracking completed"
echo "=============================================="
