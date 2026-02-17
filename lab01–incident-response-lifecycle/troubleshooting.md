# 🛠 Troubleshooting Guide – Lab 01: Incident Response Lifecycle

---

This document outlines common issues encountered during the Incident Response Lifecycle lab and their corresponding solutions.

---

## 1️⃣ Issue: Permission Denied When Accessing System Logs

### 🔍 Symptoms

- Errors when copying `/var/log/syslog`, `/var/log/auth.log`, or `/var/log/kern.log`
- “Permission denied” messages

### 💡 Cause

System log files are owned by root and require elevated privileges.

### ✅ Solution

Use `sudo` when accessing or copying protected log files:

```bash
sudo cp /var/log/syslog destination/
```

If issues persist, verify permissions:

```bash
ls -la /var/log/
```

---

## 2️⃣ Issue: Scripts Not Executing

### 🔍 Symptoms

- “Permission denied” when running script
- Script does not execute

### 💡 Cause

Script does not have execute permissions.

### ✅ Solution

Grant execute permission:

```bash
chmod +x script_name.sh
```

Verify:

```bash
ls -l script_name.sh
```

Expected permission:

```
-rwxr-xr-x
```

---

## 3️⃣ Issue: High CPU Usage Persists After Containment

### 🔍 Symptoms

- CPU still near 100%
- `yes` process still visible

### 💡 Cause

The process was not terminated properly or multiple instances are running.

### ✅ Solution

Kill specific PID:

```bash
kill -9 <PID>
```

Or terminate all related processes:

```bash
pkill -f yes
```

Verify termination:

```bash
ps aux | grep yes
```

No output should appear.

---

## 4️⃣ Issue: Cannot Find Created Files

### 🔍 Symptoms

- `find` command does not return expected files
- `/tmp/suspicious_file.txt` missing

### 💡 Cause

Wrong directory or file already quarantined.

### ✅ Solution

Check current directory:

```bash
pwd
```

List directory contents:

```bash
ls -la /tmp
```

Check quarantine directory:

```bash
ls incident_response/evidence/quarantine/
```

---

## 5️⃣ Issue: AIDE Initialization Fails

### 🔍 Symptoms

- `aideinit` command fails
- Database not created

### 💡 Cause

Missing permissions or configuration issue.

### ✅ Solution

Run with elevated privileges:

```bash
sudo aideinit
```

Verify new database file exists:

```bash
ls /var/lib/aide/
```

Copy new database:

```bash
sudo cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db
```

---

## 6️⃣ Issue: Network Monitoring Shows No Connections

### 🔍 Symptoms

- `ss -tuln` shows minimal or no activity

### 💡 Cause

In lab environments, limited services may be running.

### ✅ Solution

Verify SSH service:

```bash
systemctl status ssh
```

Minimal network activity is normal in controlled lab environments.

---

## 7️⃣ Issue: Detection Script Does Not Identify Suspicious Files

### 🔍 Symptoms

- Detection results file does not list suspicious files

### 💡 Cause

Simulation script was not executed or files were already quarantined.

### ✅ Solution

Re-run simulation:

```bash
./scripts/simulate_incident.sh
```

Re-run detection steps:

```bash
find /tmp -name "*suspicious*" -o -name "*malware*"
```

---

## 8️⃣ Issue: Volatile Evidence Files Missing

### 🔍 Symptoms

- `evidence/volatile/` directory empty

### 💡 Cause

Preservation script not executed.

### ✅ Solution

Run:

```bash
./scripts/preserve_evidence.sh
```

Verify:

```bash
ls evidence/volatile/
```

---

## 9️⃣ Issue: Continuous Monitor Script Not Logging Alerts

### 🔍 Symptoms

- No entries in `alerts.log`

### 💡 Cause

CPU usage not exceeding threshold (80%)
No suspicious files present.

### ✅ Solution

Simulate high CPU process:

```bash
yes > /dev/null &
```

Check log file:

```bash
cat logs/system/alerts.log
```

Stop test process:

```bash
pkill -f yes
```

---

## 🔟 Issue: Log Cleanup Script Does Not Move Logs

### 🔍 Symptoms

- Old logs remain in original directory

### 💡 Cause

Log files may not be older than 7 days.

### ✅ Solution

Verify file timestamps:

```bash
ls -lt logs/
```

The cleanup script moves logs older than 7 days:

```bash
-mtime +7
```

---

# 🔐 Best Practices Applied During Lab

- Always collect volatile evidence before containment
- Preserve file integrity during quarantine
- Maintain timestamped logs
- Use structured directory layout
- Document every action
- Validate system health after recovery

---

# 🏁 Final Notes

If unexpected behavior occurs:

1. Re-check directory paths
2. Verify script permissions
3. Confirm correct working directory
4. Review log files under `logs/system/`
5. Ensure required tools are installed

This troubleshooting guide ensures smooth execution of the full Incident Response Lifecycle.

---
