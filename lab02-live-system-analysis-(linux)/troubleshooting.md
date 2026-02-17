# 🛠 Troubleshooting Guide — Lab 02: Live System Analysis (Linux)

---

## Issue 1: Auditd Service Not Running

### Symptoms
- `ausearch` returns no results
- `auditctl -l` shows no rules
- Audit logs not being generated

### Verification
```bash
sudo systemctl status auditd
````

### Solution

```bash
sudo systemctl restart auditd
sudo systemctl enable auditd
```

If the service fails to start:

```bash
sudo journalctl -xe | grep audit
```

---

## Issue 2: Audit Rules Not Loading

### Symptoms

* Custom rules do not appear in `auditctl -l`
* `augenrules --load` shows no change

### Verification

```bash
sudo auditctl -l
```

### Solution

1. Ensure rules file exists in:

   ```
   /etc/audit/rules.d/
   ```
2. Check file permissions:

   ```bash
   ls -l /etc/audit/rules.d/
   ```
3. Reload rules:

   ```bash
   sudo augenrules --load
   sudo systemctl restart auditd
   ```

---

## Issue 3: Ausearch Returns No Results

### Possible Causes

* Auditd not running
* No activity generated
* Incorrect rule key used
* Log rotation occurred

### Solution

1. Verify audit service:

   ```bash
   sudo systemctl status auditd
   ```

2. Generate test activity:

   ```bash
   sudo cat /etc/passwd > /dev/null
   ```

3. Wait 10–15 seconds and retry:

   ```bash
   sudo ausearch -k identity
   ```

4. Verify audit log exists:

   ```bash
   ls -la /var/log/audit/audit.log
   ```

---

## Issue 4: Scripts Produce Empty Output Files

### Causes

* Insufficient permissions
* Logs not present
* Commands returning no results

### Solution

* Run scripts with proper privileges:

  ```bash
  sudo ./audit_analyzer.sh
  ```
* Verify log files exist:

  ```bash
  ls /var/log/
  ```
* Ensure scripts are executable:

  ```bash
  chmod +x script_name.sh
  ```

---

## Issue 5: Permission Denied Errors

### Common Scenario

Accessing `/var/log/auth.log` or `/var/log/audit/audit.log`

### Solution

Run with sudo:

```bash
sudo cat /var/log/auth.log
```

Or execute script as:

```bash
sudo ./log_correlator.sh
```

---

## Issue 6: Threat Hunting Script Runs Slowly

### Cause

Full filesystem scans (e.g., SUID, SGID, world-writable searches)

### Optimization

Limit scope:

```bash
find /home -perm -4000 -type f
```

Or redirect errors to avoid delays:

```bash
find / -perm -4000 -type f 2>/dev/null
```

---

## Issue 7: Correlation Script Shows No SSH Events

### Explanation

In lab environment, no SSH brute-force attempts may exist.

### Test Simulation

Trigger authentication activity:

```bash
sudo ssh localhost
```

Then re-run correlation script.

---

## Issue 8: nft Command Not Found in Threat Hunting

### Cause

nftables not installed or not configured.

### Solution

Install nftables:

```bash
sudo apt install nftables
```

Verify:

```bash
sudo nft list ruleset
```

---

## Issue 9: High CPU Usage During Analysis

### Cause

Large audit logs or heavy process enumeration

### Solution

* Monitor system:

  ```bash
  htop
  ```
* Reduce log scanning scope
* Run during low system usage periods

---

## Issue 10: Disk Space Issues

### Cause

Multiple analysis directories created with timestamps

### Check Disk Usage

```bash
df -h
du -sh *
```

### Cleanup Old Analysis

```bash
rm -rf system_analysis_*
rm -rf audit_analysis_*
rm -rf correlation_analysis_*
rm -rf threat_hunting_*
```

---

# 🔐 Best Practices Learned

* Always verify service status before analysis
* Backup configurations before modifying
* Use timestamps in output directories
* Run forensic scripts with controlled privileges
* Preserve original logs before analysis
* Avoid modifying live evidence
* Document all actions performed

---

# 📌 Final Notes

Proper troubleshooting ensures:

* Reliable evidence collection
* Accurate forensic conclusions
* Reduced investigation errors
* Faster incident response

This structured approach mirrors real-world SOC and forensic investigation workflows.
