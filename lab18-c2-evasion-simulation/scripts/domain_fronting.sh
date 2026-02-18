#!/bin/bash

FRONT_DOMAIN="www.google.com"

echo "Simulating domain fronting..."
curl -H "Host: $FRONT_DOMAIN" http://localhost:8080
