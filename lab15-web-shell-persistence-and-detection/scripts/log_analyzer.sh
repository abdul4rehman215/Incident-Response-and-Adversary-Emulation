#!/bin/bash

ACCESS_LOG="/var/log/apache2/access.log"

analyze_logs() {

 echo "======================================"
 echo "        Web Log Analysis Report"
 echo "======================================"

 if [ ! -f "$ACCESS_LOG" ]; then
     echo "Access log not found!"
     exit 1
 fi

 echo
 echo "[1] Suspicious Parameters (cmd=, exec=, x=)"
 grep -E "(cmd=|exec=|x=)" "$ACCESS_LOG"

 echo
 echo "[2] Suspicious User Agents (curl, wget, python)"
 grep -Ei "(curl|wget|python)" "$ACCESS_LOG"

 echo
 echo "[3] POST Requests to PHP Files"
 grep "POST" "$ACCESS_LOG" | grep ".php"

 echo
 echo "[4] High Frequency Requests by IP"
 awk '{print $1}' "$ACCESS_LOG" | sort | uniq -c | sort -nr | head -10

 echo
 total_requests=$(wc -l < "$ACCESS_LOG")
 echo "[5] Total Requests: $total_requests"

 echo "======================================"
}

analyze_logs
