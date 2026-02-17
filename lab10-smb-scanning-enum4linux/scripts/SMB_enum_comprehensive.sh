#!/bin/bash
# =========================================================
# SMB_enum_comprehensive.sh
# Lab 10 – SMB Scanning with Enum4Linux
# Comprehensive Enumeration Automation Script
# =========================================================

TARGET=$1
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="smb_enum_${TIMESTAMP}"

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <target_ip>"
    echo "Example: $0 127.0.0.1"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

echo "================================================="
echo "[+] Starting comprehensive SMB enumeration"
echo "================================================="
echo "[+] Target: $TARGET"
echo "[+] Output Directory: $OUTPUT_DIR"
echo ""

# ---------------------------------------------------------
# Basic Enumeration
# ---------------------------------------------------------
echo "[+] Running full enumeration (-a)..."
enum4linux -a "$TARGET" > "$OUTPUT_DIR/basic_enum.txt" 2>&1

if [ $? -eq 0 ]; then
    echo "    [SUCCESS] Basic enumeration completed"
else
    echo "    [WARNING] Basic enumeration encountered issues"
fi

# ---------------------------------------------------------
# User Enumeration
# ---------------------------------------------------------
echo "[+] Extracting user information (-U)..."
enum4linux -U "$TARGET" > "$OUTPUT_DIR/users.txt" 2>&1

# ---------------------------------------------------------
# Group Enumeration
# ---------------------------------------------------------
echo "[+] Extracting group information (-G)..."
enum4linux -G "$TARGET" > "$OUTPUT_DIR/groups.txt" 2>&1

# ---------------------------------------------------------
# Share Enumeration
# ---------------------------------------------------------
echo "[+] Extracting share information (-S)..."
enum4linux -S "$TARGET" > "$OUTPUT_DIR/shares.txt" 2>&1

# ---------------------------------------------------------
# Password Policy Enumeration
# ---------------------------------------------------------
echo "[+] Extracting password policy (-P)..."
enum4linux -P "$TARGET" > "$OUTPUT_DIR/password_policy.txt" 2>&1

# ---------------------------------------------------------
# OS Information Enumeration
# ---------------------------------------------------------
echo "[+] Extracting OS information (-o)..."
enum4linux -o "$TARGET" > "$OUTPUT_DIR/os_info.txt" 2>&1

# ---------------------------------------------------------
# Summary
# ---------------------------------------------------------
echo ""
echo "================================================="
echo "[✓] SMB Enumeration Complete"
echo "================================================="
echo "[+] Results saved in directory: $OUTPUT_DIR"
echo ""
echo "Generated Files:"
ls -1 "$OUTPUT_DIR"
echo ""
echo "To analyze results:"
echo "python3 analyze_smb_results.py $OUTPUT_DIR"
echo ""
