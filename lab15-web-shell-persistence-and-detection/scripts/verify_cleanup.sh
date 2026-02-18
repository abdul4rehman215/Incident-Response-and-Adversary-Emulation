#!/bin/bash

WEB_ROOT="/var/www/html"
ACCESS_LOG="/var/log/apache2/access.log"

echo "================================"
echo "Cleanup Verification Report"
echo "================================"

echo
echo "[1] Scanning for remaining suspicious PHP files..."
grep -rE "(system|exec|eval|base64_decode)" "$WEB_ROOT"

echo
echo "[2] Checking directory permissions..."
find "$WEB_ROOT" -type d -exec stat -c "%A %n" {} \; | head

echo
echo "[3] Checking .htaccess in uploads..."
if [ -f "$WEB_ROOT/testapp/uploads/.htaccess" ]; then
 echo ".htaccess exists in uploads."
else
 echo "Warning: No .htaccess found in uploads."
fi

echo
echo "[4] Checking recent suspicious log entries..."
grep -E "(cmd=|exec=|x=)" "$ACCESS_LOG" | tail -10

echo
echo "Verification complete."
