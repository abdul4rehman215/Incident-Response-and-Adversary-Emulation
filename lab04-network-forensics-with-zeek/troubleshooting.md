# 🛠 Troubleshooting Guide – Lab 4: Network Forensics with Zeek

---

## Issue 1: Zeek Command Not Found

### Problem:
`zeek: command not found`

### Solution:
Check installation:
```bash
which zeek
````

If not in PATH:

```bash
export PATH=/opt/zeek/bin:$PATH
```

Or locate installation:

```bash
find /usr -name zeek 2>/dev/null
```

---

## Issue 2: Permission Denied When Capturing Traffic

### Problem:

Zeek cannot capture traffic on interface.

### Solution:

Run with sudo:

```bash
sudo zeek -i ens5 local.zeek
```

Or add user to pcap group:

```bash
sudo usermod -a -G pcap $USER
```

Log out and back in.

---

## Issue 3: No Log Files Generated

### Possible Causes:

* Wrong interface selected
* No traffic during capture
* Script syntax error

### Solutions:

Check interface:

```bash
ip link show
```

Test traffic:

```bash
curl http://example.com
```

Check script syntax:

```bash
zeek -C local.zeek
```

---

## Issue 4: JSON Parsing Errors

### Problem:

`jq` returns parsing errors.

### Solution:

Ensure JSON logging is enabled:

```zeek
redef LogAscii::use_json = T;
```

Verify first line:

```bash
head -1 conn.log
```

---

## Issue 5: Detection Scripts Not Triggering

### Possible Causes:

* Traffic not matching detection logic
* Wrong domain format
* Script not loaded

### Solutions:

Confirm script loading:

```bash
sudo zeek -i ens5 comprehensive_detection.zeek
```

Check malicious_activity.log:

```bash
cat malicious_activity.log
```

Generate test traffic:

```bash
./generate_test_traffic.sh
```

---

## Issue 6: Port Scan Detection Not Working

### Problem:

No port scan alert triggered.

### Solutions:

Ensure enough ports are scanned within time window:

```bash
for port in 1 2 3 4 5 6 7 8 9 10; do nc -z localhost $port; done
```

Verify threshold inside script:

```zeek
const PORT_SCAN_THRESHOLD: count = 10;
```

---

## Issue 7: Timeline Script Fails

### Problem:

jq not found or date conversion fails.

### Solutions:

Install jq:

```bash
sudo apt install jq
```

Verify JSON format:

```bash
jq . conn.log | head
```

---

## Issue 8: High CPU Usage During Capture

### Cause:

Large traffic volume or long capture window.

### Solution:

Limit capture time:

```bash
sudo timeout 60 zeek -i ens5 local.zeek
```

---

## Issue 9: Malicious Domain Detection Not Triggering

### Cause:

DNS query format mismatch.

### Solution:

Ensure exact match inside suspicious_domains set:

```zeek
const suspicious_domains: set[string] = {
    "malware-example.com"
};
```

Verify DNS log:

```bash
cat dns.log | jq .
```

---

## Issue 10: Log Files Empty

### Cause:

Monitoring wrong interface.

### Fix:

Find active interface:

```bash
ip route | grep default
```

Use that interface with Zeek.

---

# ✅ Best Practices

* Always verify interface before capture
* Enable JSON logging for automation
* Use timeout to prevent runaway capture
* Test detection rules with controlled traffic
* Keep detection scripts modular
* Archive logs after analysis

---

# 🔐 Operational Security Reminder

In production environments:

* Restrict log access permissions
* Store logs securely
* Forward logs to SIEM
* Regularly update detection signatures
* Monitor for log tampering

---

# 🎯 Final Note

If Zeek runs but produces no alerts:

1. Verify traffic exists.
2. Verify detection logic.
3. Confirm script is loaded.
4. Generate controlled test traffic.

Systematic troubleshooting ensures reliable network forensic analysis.
