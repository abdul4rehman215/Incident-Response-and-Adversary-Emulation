#!/bin/bash

echo "Starting web attack simulation..."

# Install apache2 for testing
sudo apt install -y apache2
sudo systemctl start apache2

# Simulate SQL injection attempts
curl -s "http://localhost/index.php?id=1' OR '1'='1" > /dev/null
curl -s "http://localhost/login.php?user=admin&pass=' OR 1=1--" > /dev/null
curl -s "http://localhost/search.php?q=<script>alert('XSS')</script>" > /dev/null

# Simulate directory traversal
curl -s "http://localhost/../../../etc/passwd" > /dev/null
curl -s "http://localhost/../../../../etc/shadow" > /dev/null

# Simulate brute force attempts
for i in {1..10}; do
    curl -s -X POST "http://localhost/login.php" \
        -d "username=admin&password=password$i" > /dev/null
    sleep 1
done

echo "Web attack simulation completed"
