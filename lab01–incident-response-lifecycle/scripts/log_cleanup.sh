#!/bin/bash

ARCHIVE_DIR="$HOME/incident_response/logs/archive"
LOG_DIR="$HOME/incident_response/logs"

mkdir -p "$ARCHIVE_DIR"

find "$LOG_DIR" -type f -name "*.log" -mtime +7 -exec mv {} "$ARCHIVE_DIR"/ \;

echo "$(date): Log cleanup completed" >> "$HOME/incident_response/logs/system/maintenance.log"
