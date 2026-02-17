#!/bin/bash
# Rate Limiting Test Script (Completed)

TARGET="127.0.0.1"
SERVICE=$1
ATTEMPTS=$2
DELAY=0.2

if [ $# -ne 2 ]; then
    echo "Usage: $0 <service: ftp|http> <attempts>"
    exit 1
fi

SUCCESS=0
FAIL=0
BLOCKED=0

test_rate_limiting() {
    echo "Testing rate limiting on $SERVICE..."
    echo "======================================"

    for ((i=1; i<=ATTEMPTS; i++)); do

        if [ "$SERVICE" == "ftp" ]; then
            START=$(date +%s%N)
            curl -s --user baduser:badpass "ftp://$TARGET" > /dev/null 2>&1
            STATUS=$?
            END=$(date +%s%N)

        elif [ "$SERVICE" == "http" ]; then
            START=$(date +%s%N)
            RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -u baduser:badpass "http://$TARGET/protected/")
            END=$(date +%s%N)

            if [ "$RESPONSE" == "401" ]; then
                STATUS=1
            elif [ "$RESPONSE" == "200" ]; then
                STATUS=0
            else
                STATUS=2
            fi
        else
            echo "Invalid service. Use ftp or http."
            exit 1
        fi

        DURATION=$(( (END - START)/1000000 ))
        echo "Attempt $i - Response Time: ${DURATION} ms"

        if [ $STATUS -eq 0 ]; then
            SUCCESS=$((SUCCESS+1))
        elif [ $STATUS -eq 1 ]; then
            FAIL=$((FAIL+1))
        else
            BLOCKED=$((BLOCKED+1))
        fi

        sleep $DELAY
    done

    echo "======================================"
    echo "Rate Limiting Test Summary"
    echo "Total Attempts: $ATTEMPTS"
    echo "Successful: $SUCCESS"
    echo "Failed: $FAIL"
    echo "Blocked/Other: $BLOCKED"
    echo "======================================"

    if [ $BLOCKED -gt 0 ]; then
        echo "Possible rate limiting or blocking detected."
    else
        echo "No rate limiting detected."
    fi
}

test_rate_limiting
