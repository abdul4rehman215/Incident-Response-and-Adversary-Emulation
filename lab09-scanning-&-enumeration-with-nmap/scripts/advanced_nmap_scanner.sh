#!/bin/bash

# =========================================
# Advanced Multi-Target Nmap Scanner
# Lab 9: Scanning & Enumeration with Nmap
# =========================================

echo "========================================="
echo " Advanced Multi-Target Nmap Scanner"
echo "========================================="
echo ""

usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo " -t Single target (IP or hostname)"
    echo " -f File containing list of targets"
    echo " -p Specific ports to scan (e.g., 22,80,443)"
    echo " -o Output directory name"
    echo " -q Quick scan only"
    echo " -a Include aggressive scans"
    echo " -h Show this help message"
    echo ""
    echo "Examples:"
    echo " $0 -t 127.0.0.1 -p 22,80,443"
    echo " $0 -f targets.txt -a"
    echo " $0 -t localhost -q -o my_scan_results"
    exit 1
}

TARGETS=""
TARGET_FILE=""
PORTS=""
OUTPUT_DIR=""
QUICK_ONLY=false
AGGRESSIVE=false

while getopts "t:f:p:o:qah" opt; do
    case $opt in
        t) TARGETS="$OPTARG" ;;
        f) TARGET_FILE="$OPTARG" ;;
        p) PORTS="$OPTARG" ;;
        o) OUTPUT_DIR="$OPTARG" ;;
        q) QUICK_ONLY=true ;;
        a) AGGRESSIVE=true ;;
        h) usage ;;
        *) usage ;;
    esac
done

if [ -z "$TARGETS" ] && [ -z "$TARGET_FILE" ]; then
    echo "Error: Must specify either a target (-t) or target file (-f)"
    usage
fi

if [ -z "$OUTPUT_DIR" ]; then
    OUTPUT_DIR="advanced_scan_$(date +%Y%m%d_%H%M%S)"
fi

mkdir -p "$OUTPUT_DIR"

echo "Configuration:"
echo " Targets: ${TARGETS:-$TARGET_FILE}"
echo " Ports: ${PORTS:-All common ports}"
echo " Output: $OUTPUT_DIR"
echo " Quick only: $QUICK_ONLY"
echo " Aggressive: $AGGRESSIVE"
echo ""

#############################################
# FUNCTION: Scan Target
#############################################
scan_target() {

    local target=$1
    local safe_target="${target//\//_}"
    local target_dir="$OUTPUT_DIR/$safe_target"

    mkdir -p "$target_dir"

    echo "[+] Scanning target: $target"

    #########################################
    # Port Scan
    #########################################
    if [ -n "$PORTS" ]; then
        echo " Scanning specified ports: $PORTS"
        nmap -p "$PORTS" -T4 "$target" > "$target_dir/port_scan.txt" 2>&1
    else
        echo " Scanning common ports..."
        nmap -T4 "$target" > "$target_dir/port_scan.txt" 2>&1
    fi

    #########################################
    # Service Detection
    #########################################
    if [ "$QUICK_ONLY" = false ]; then
        echo " Detecting services..."
        nmap -sV -T4 "$target" > "$target_dir/service_detection.txt" 2>&1

        #########################################
        # Aggressive Scan
        #########################################
        if [ "$AGGRESSIVE" = true ]; then
            echo " Running aggressive scan..."
            nmap -A -T4 "$target" > "$target_dir/aggressive_scan.txt" 2>&1
        fi
    fi

    echo " [COMPLETED] Results saved to: $target_dir/"
    echo ""
}

#############################################
# MAIN EXECUTION LOGIC
#############################################

if [ -n "$TARGETS" ]; then

    scan_target "$TARGETS"

elif [ -n "$TARGET_FILE" ]; then

    if [ ! -f "$TARGET_FILE" ]; then
        echo "Error: Target file '$TARGET_FILE' not found"
        exit 1
    fi

    while IFS= read -r target; do
        if [ -n "$target" ] && [[ ! "$target" =~ ^# ]]; then
            scan_target "$target"
        fi
    done < "$TARGET_FILE"

fi

echo "========================================="
echo " ALL SCANS COMPLETED"
echo "========================================="
echo "Results saved to: $OUTPUT_DIR/"
