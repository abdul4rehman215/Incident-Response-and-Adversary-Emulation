#!/bin/bash

echo "=== Suricata Performance Monitor ==="
echo "Timestamp: $(date)"
echo

if pgrep suricata > /dev/null; then
  echo "Status: Suricata is running"

  echo "Process Information:"
  ps aux | grep suricata | grep -v grep
  echo

  echo "Memory Usage:"
  pmap $(pgrep suricata) | tail -1
  echo

  echo "Recent Statistics (last 5 entries):"
  sudo tail -5 /var/log/suricata/stats.log
  echo

  echo "Log File Sizes:"
  ls -lh /var/log/suricata/
else
  echo "Status: Suricata is not running"
  echo "Use 'sudo systemctl start suricata' to start the service"
fi
