#!/bin/bash

echo "================================================="
echo "=== COMPILING INCIDENT RESPONSE DOCUMENTATION ==="
echo "================================================="
echo

BASE_DIR=~/incident-response-lab
FINAL_DIR=$BASE_DIR/final_documentation
CONFIG_DIR=$FINAL_DIR/configurations
EVIDENCE_DIR=$BASE_DIR/evidence

mkdir -p $FINAL_DIR
mkdir -p $CONFIG_DIR

echo "[*] Copying reports..."
cp $BASE_DIR/reports/* $FINAL_DIR/

echo "[*] Generating master incident report..."

cat > $FINAL_DIR/master_incident_report.txt << MASTER_EOF
MASTER INCIDENT RESPONSE REPORT
===============================

Lab: Final Incident Response Simulation
Date: $(date)
Analyst: Security Student

This lab demonstrated a full incident lifecycle:
- Detection
- Containment
- Eradication
- Recovery
- Documentation

Tools Used:
- Wazuh
- Suricata
- Zeek

All simulated threats successfully contained.
MASTER_EOF

echo "[*] Backing up configurations..."

sudo cp /var/ossec/etc/ossec.conf \
    $CONFIG_DIR/wazuh_config.xml

sudo cp /etc/suricata/suricata.yaml \
    $CONFIG_DIR/suricata_config.yaml

sudo cp /opt/zeek/etc/node.cfg \
    $CONFIG_DIR/zeek_config.cfg

echo "[*] Archiving evidence..."
tar -czf $FINAL_DIR/evidence_archive.tar.gz $EVIDENCE_DIR

echo "[*] Generating manifest..."

echo "DOCUMENTATION PACKAGE MANIFEST" > $FINAL_DIR/manifest.txt
echo "Generated: $(date)" >> $FINAL_DIR/manifest.txt
echo "" >> $FINAL_DIR/manifest.txt

find $FINAL_DIR -type f -exec ls -lh {} \; \
    >> $FINAL_DIR/manifest.txt

echo
echo "Documentation compilation completed."
ls -lah $FINAL_DIR
