#!/bin/bash

WEB_ROOT="/var/www/html"
QUARANTINE_DIR="$HOME/webshell_quarantine"
BACKUP_DIR="$HOME/webshell_backup_$(date +%Y%m%d_%H%M%S)"

mkdir -p "$QUARANTINE_DIR"
mkdir -p "$BACKUP_DIR"

SUSPICIOUS_FUNCTIONS=("system" "exec" "shell_exec" "passthru" "eval" "base64_decode")

quarantine_file() {

 local file=$1
 local reason=$2

 cp "$file" "$BACKUP_DIR/"
 mv "$file" "$QUARANTINE_DIR/"

 echo "[QUARANTINED] $file - Reason: $reason"
}

remove_webshells() {

 echo "Scanning for web shells..."

 find "$WEB_ROOT" -name "*.php" -type f | while read file; do

     for func in "${SUSPICIOUS_FUNCTIONS[@]}"; do
         if grep -q "$func" "$file"; then
             quarantine_file "$file" "Suspicious function: $func"
         fi
     done
 done
}

secure_directories() {

 echo "Securing directories..."

 find "$WEB_ROOT" -type d -exec chmod 755 {} \;
 find "$WEB_ROOT" -type f -exec chmod 644 {} \;

 if [ -d "$WEB_ROOT/testapp/uploads" ]; then
     echo "php_flag engine off" > "$WEB_ROOT/testapp/uploads/.htaccess"
 fi
}

echo "================================"
echo "Web Shell Removal Tool"
echo "================================"
read -p "Continue? (y/N): " confirm

if [[ $confirm == [yY] ]]; then
 remove_webshells
 secure_directories
 echo "Removal complete."
 echo "Quarantine: $QUARANTINE_DIR"
 echo "Backup: $BACKUP_DIR"
fi
