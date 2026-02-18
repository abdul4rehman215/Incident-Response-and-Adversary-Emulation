#!/bin/bash

echo "Starting port scan simulation..."

TARGET="127.0.0.1"

# Simulate TCP SYN scan
for port in 22 80 443 3389 445 135; do
    timeout 1 bash -c "</dev/tcp/$TARGET/$port" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "Port $port is open on $TARGET"
    fi
    sleep 0.5
done

# Simulate UDP scan
for port in 53 161 123; do
    echo "test" | timeout 1 nc -u $TARGET $port 2>/dev/null
    sleep 0.5
done

echo "Port scan simulation completed"
