#!/bin/bash

echo "1. Generating normal HTTP traffic..."
curl -s http://httpbin.org/get > /dev/null &
curl -s http://example.com > /dev/null &

echo "2. Generating suspicious user agent traffic..."
curl -s -A "sqlmap/1.0" http://httpbin.org/user-agent > /dev/null &
curl -s -A "nikto/2.1.6" http://httpbin.org/user-agent > /dev/null &

echo "3. Generating DNS queries..."
nslookup google.com > /dev/null &
nslookup malware-example.com > /dev/null &

echo "4. Simulating port scan..."
for port in 22 23 25 53 80 110 143 443 993 995; do
 timeout 1 nc -z localhost $port 2>/dev/null &
done

echo "5. Generating file transfer traffic..."
wget -q -O /dev/null http://httpbin.org/bytes/1024 &

echo "Test traffic generation complete. Waiting for connections to finish..."
sleep 10
