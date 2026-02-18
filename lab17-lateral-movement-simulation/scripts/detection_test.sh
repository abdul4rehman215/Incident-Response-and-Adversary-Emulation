#!/bin/bash

echo "=== Detection Test ==="

echo
echo "[1] Checking beacon processes..."
ps aux | grep beacon_agent | grep -v grep

echo
echo "[2] Checking listening ports..."
netstat -tulpn | grep 8080

echo
echo "[3] Checking SSH sessions..."
who
