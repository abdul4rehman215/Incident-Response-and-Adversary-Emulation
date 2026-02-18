#!/bin/bash

WEB_ROOT="/var/www/html"
SUSPICIOUS_FUNCTIONS=("system" "exec" "shell_exec" "passthru" "eval" "base64_decode")

echo "Starting Web Shell Scan..."
echo "================================"

find "$WEB_ROOT" -name "*.php" -type f | while read file; do

    for func in "${SUSPICIOUS_FUNCTIONS[@]}"; do
        if grep -q "$func" "$file"; then
            echo "[!] Suspicious function '$func' found in $file"
        fi
    done

    PERMS=$(stat -c "%a" "$file")
    if [[ "$PERMS" == "777" ]]; then
        echo "[!] Insecure permissions (777) on $file"
    fi

    if grep -q "base64_decode" "$file"; then
        echo "[!] Possible encoded payload in $file"
    fi
done

echo "================================"
echo "Scan complete."
