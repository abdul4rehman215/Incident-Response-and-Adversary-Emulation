#!/bin/bash

echo "Starting attack simulation scenarios..."

# Scenario 1: Port scanning simulation
echo "Scenario 1: Port scanning simulation"
nmap -sS -O 127.0.0.1 > /dev/null 2>&1

# Scenario 2: HTTP directory traversal attempt
echo "Scenario 2: HTTP directory traversal"
curl -s "http://httpbin.org/get?file=../../../etc/passwd" > /dev/null

# Scenario 3: SQL injection attempt
echo "Scenario 3: SQL injection simulation"
curl -s "http://httpbin.org/get?id=1' OR '1'='1" > /dev/null

# Scenario 4: Multiple failed SSH attempts
echo "Scenario 4: SSH brute force simulation"
for i in {1..10}; do
  timeout 1 ssh -o ConnectTimeout=1 fake_user@127.0.0.1 2>/dev/null
  sleep 0.5
done

# Scenario 5: DNS tunneling simulation
echo "Scenario 5: DNS tunneling simulation"
for subdomain in data1 data2 data3 malicious; do
  dig @8.8.8.8 ${subdomain}.suspicious-domain.com > /dev/null 2>&1
  sleep 1
done

echo "Attack simulation complete. Check Suricata logs for detections."
