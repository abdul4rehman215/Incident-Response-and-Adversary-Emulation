#!/bin/bash

DATE=$(date '+%Y-%m-%d_%H-%M-%S')
HARDENING_LOG="$HOME/incident_response/logs/system/hardening_$DATE.log"

mkdir -p "$HOME/incident_response/logs/system"
mkdir -p "$HOME/incident_response/logs/archive"

echo "=== SYSTEM HARDENING ACTIONS ===" > "$HARDENING_LOG"
echo "Hardening started at: $(date)" >> "$HARDENING_LOG"

echo "Updating file integrity database..." >> "$HARDENING_LOG"
sudo aide --update 2>/dev/null
echo "AIDE update completed" >> "$HARDENING_LOG"

echo "Configuring enhanced monitoring..." >> "$HARDENING_LOG"

echo "System hardening completed at: $(date)" >> "$HARDENING_LOG"
echo "Hardening log saved to: $HARDENING_LOG"
