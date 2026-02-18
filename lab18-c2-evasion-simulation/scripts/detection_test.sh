#!/bin/bash

echo "Checking for beacon processes..."
ps aux | grep beacon.py | grep -v grep

echo
echo "Checking open connections..."
netstat -tulpn | grep 8080
