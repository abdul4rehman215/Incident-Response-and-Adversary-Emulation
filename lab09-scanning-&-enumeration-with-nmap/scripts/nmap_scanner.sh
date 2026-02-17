#!/bin/bash

# =========================================
# Nmap Automated Scanner Script
# Lab 9: Scanning & Enumeration with Nmap
# =========================================

echo "========================================="
echo " Automated Nmap Scanner v1.0"
echo "========================================="
echo ""

if [ $# -eq 0 ]; then
    echo "Usage: $0 <target_ip>"
    echo "Example: $0 127.0.0.1"
    exit 1
fi

TARGET="$1"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_DIR="nmap_results_${TIMESTAMP}"

mkdir -p "$OUTPUT_DIR"

echo "Target: $TARGET"
echo "Output Directory: $OUTPUT_DIR"
echo "Timestamp: $TIMESTAMP"
echo ""

#############################################
# FUNCTION: Host Discovery
#############################################
host_discovery() {
    echo "[+] Starting Host Discovery..."
    echo " Performing ping scan..."
    nmap -sn "$TARGET" > "$OUTPUT_DIR/host_discovery.txt" 2>&1

    if [ $? -eq 0 ]; then
        echo " [SUCCESS] Host discovery completed"
        echo " Results saved to: $OUTPUT_DIR/host_discovery.txt"
    else
        echo " [ERROR] Host discovery failed"
    fi
    echo ""
}

#############################################
# FUNCTION: Quick Port Scan
#############################################
quick_scan() {
    echo "[+] Starting Quick Port Scan..."
    echo " Scanning top 1000 ports..."
    nmap -T4 -F "$TARGET" > "$OUTPUT_DIR/quick_scan.txt" 2>&1

    if [ $? -eq 0 ]; then
        echo " [SUCCESS] Quick scan completed"
        echo " Results saved to: $OUTPUT_DIR/quick_scan.txt"
    else
        echo " [ERROR] Quick scan failed"
    fi
    echo ""
}

#############################################
# FUNCTION: Comprehensive Scan
#############################################
comprehensive_scan() {
    echo "[+] Starting Comprehensive Port Scan..."
    echo " Scanning all 65535 ports (this may take a while)..."
    nmap -p- -T4 "$TARGET" > "$OUTPUT_DIR/comprehensive_scan.txt" 2>&1

    if [ $? -eq 0 ]; then
        echo " [SUCCESS] Comprehensive scan completed"
        echo " Results saved to: $OUTPUT_DIR/comprehensive_scan.txt"
    else
        echo " [ERROR] Comprehensive scan failed"
    fi
    echo ""
}

#############################################
# FUNCTION: Service Detection
#############################################
service_detection() {
    echo "[+] Starting Service Detection..."
    echo " Detecting services and versions..."
    nmap -sV -T4 "$TARGET" > "$OUTPUT_DIR/service_detection.txt" 2>&1

    if [ $? -eq 0 ]; then
        echo " [SUCCESS] Service detection completed"
        echo " Results saved to: $OUTPUT_DIR/service_detection.txt"
    else
        echo " [ERROR] Service detection failed"
    fi
    echo ""
}

#############################################
# FUNCTION: OS Detection
#############################################
os_detection() {
    echo "[+] Starting OS Detection..."
    echo " Attempting to identify operating system..."
    sudo nmap -O "$TARGET" > "$OUTPUT_DIR/os_detection.txt" 2>&1

    if [ $? -eq 0 ]; then
        echo " [SUCCESS] OS detection completed"
        echo " Results saved to: $OUTPUT_DIR/os_detection.txt"
    else
        echo " [WARNING] OS detection may require root privileges"
        echo " Results saved to: $OUTPUT_DIR/os_detection.txt"
    fi
    echo ""
}

#############################################
# FUNCTION: Vulnerability Scan
#############################################
vulnerability_scan() {
    echo "[+] Starting Vulnerability Scan..."
    echo " Running NSE vulnerability scripts..."
    nmap --script vuln -T4 "$TARGET" > "$OUTPUT_DIR/vulnerability_scan.txt" 2>&1

    if [ $? -eq 0 ]; then
        echo " [SUCCESS] Vulnerability scan completed"
        echo " Results saved to: $OUTPUT_DIR/vulnerability_scan.txt"
    else
        echo " [ERROR] Vulnerability scan failed"
    fi
    echo ""
}

#############################################
# FUNCTION: Aggressive Scan
#############################################
aggressive_scan() {
    echo "[+] Starting Aggressive Scan..."
    echo " Performing comprehensive enumeration..."
    nmap -A -T4 "$TARGET" > "$OUTPUT_DIR/aggressive_scan.txt" 2>&1

    if [ $? -eq 0 ]; then
        echo " [SUCCESS] Aggressive scan completed"
        echo " Results saved to: $OUTPUT_DIR/aggressive_scan.txt"
    else
        echo " [ERROR] Aggressive scan failed"
    fi
    echo ""
}

#############################################
# FUNCTION: Generate Report
#############################################
generate_report() {

    echo "[+] Generating Summary Report..."

    REPORT_FILE="$OUTPUT_DIR/scan_summary_report.txt"

    {
        echo "========================================="
        echo " NMAP SCAN SUMMARY REPORT"
        echo "========================================="
        echo ""
        echo "Target: $TARGET"
        echo "Scan Date: $(date)"
        echo "Scan Duration: $(($(date +%s) - START_TIME)) seconds"
        echo ""
        echo "OPEN PORTS DISCOVERED:"
        echo "====================="
        grep "open" "$OUTPUT_DIR/quick_scan.txt" 2>/dev/null
        echo ""
        echo "SERVICES DETECTED:"
        echo "================="
        grep "open" "$OUTPUT_DIR/service_detection.txt" 2>/dev/null
        echo ""
        echo "GENERATED FILES:"
        echo "==============="
        ls -la "$OUTPUT_DIR/"
    } > "$REPORT_FILE"

    echo " [SUCCESS] Summary report generated"
    echo " Report saved to: $REPORT_FILE"
    echo ""
}

#############################################
# MAIN EXECUTION
#############################################

START_TIME=$(date +%s)

echo "Starting automated Nmap scan sequence..."
echo ""

host_discovery
quick_scan
service_detection

echo "Do you want to run advanced scans? (OS detection, vulnerability scan, aggressive scan)"
echo "Warning: These scans may take longer and require root privileges for some features."
read -p "Continue with advanced scans? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Running advanced scans..."
    os_detection
    vulnerability_scan
    aggressive_scan
fi

generate_report

echo "========================================="
echo " SCAN SEQUENCE COMPLETED"
echo "========================================="
echo ""
echo "All results have been saved to: $OUTPUT_DIR/"
echo "Summary report: $OUTPUT_DIR/scan_summary_report.txt"
echo ""
echo "To view the summary report:"
echo "cat $OUTPUT_DIR/scan_summary_report.txt"
