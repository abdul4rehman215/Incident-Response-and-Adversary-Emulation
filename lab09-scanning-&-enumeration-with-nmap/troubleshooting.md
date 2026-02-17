# 🛠 Troubleshooting Guide - Lab 09: Scanning & Enumeration with Nmap

---

## 🔹 Issue 1: Permission Denied Errors

### Problem:
Advanced scans (SYN, OS detection) fail.

### Cause:
These require raw socket access (root privileges).

### Solution:

```bash
sudo nmap -sS 127.0.0.1
sudo nmap -O 127.0.0.1
````

Verify user permissions:

```bash
whoami
```

---

## 🔹 Issue 2: Nmap Not Installed

### Problem:

```
nmap: command not found
```

### Solution:

```bash
sudo apt update
sudo apt install nmap -y
```

Verify installation:

```bash
nmap --version
```

---

## 🔹 Issue 3: Scan Very Slow

### Problem:

Full port scans take too long.

### Solution:

Use timing templates:

Fast scan:

```bash
nmap -T4 127.0.0.1
```

Very fast:

```bash
nmap -T5 127.0.0.1
```

Scan limited ports:

```bash
nmap -p 1-1000 127.0.0.1
```

---

## 🔹 Issue 4: No Open Ports Found

### Problem:

Scan returns no open ports.

### Cause:

Services may not be running.

### Solution:

Start test services:

```bash
sudo systemctl start ssh
sudo systemctl start apache2
```

Verify:

```bash
sudo ss -tlnp
```

---

## 🔹 Issue 5: OS Detection Fails

### Problem:


OS detection requires root privileges.


### Solution:

```bash
sudo nmap -O target
```

Also ensure:

* Target is not heavily firewalled
* Enough ports are open for fingerprinting

---

## 🔹 Issue 6: UDP Scan Shows open|filtered

### Explanation:

UDP is connectionless.
Nmap cannot always confirm if port is open or filtered.

### Solution:

Use version detection:

```bash
sudo nmap -sU -sV target
```

---

## 🔹 Issue 7: NSE Scripts Not Working

### Problem:

Script fails or no output.

### Solution:

Update script database:

```bash
sudo nmap --script-updatedb
```

Verify script path:

```bash
ls /usr/share/nmap/scripts/
```

---

## 🔹 Issue 8: Bash Script Errors

### Problem:

Script fails to execute.

### Solution:

Make executable:

```bash
chmod +x script_name.sh
```

Check syntax:

```bash
bash -n script_name.sh
```

Debug:

```bash
bash -x script_name.sh
```

---

## 🔹 Issue 9: Firewall Blocking Scans

### Problem:

All ports show filtered.

### Check Firewall:

```bash
sudo ufw status
```

Temporarily disable for lab:

```bash
sudo ufw disable
```

Re-enable after testing:

```bash
sudo ufw enable
```

---

## 🔹 Issue 10: Network Connectivity Problems

### Test Internet:

```bash
ping -c 4 google.com
```

### Check DNS:

```bash
nslookup example.com
```

---

# 🔐 Security & Ethical Reminder

✔ Only scan systems you own
✔ Always have authorization
✔ Document scanning activities
✔ Avoid scanning random internet targets

Unauthorized scanning can be illegal.

---

# ✅ Validation Checklist

✔ Nmap installed
✔ Root privileges tested
✔ Host discovery working
✔ Port scanning working
✔ Service detection verified
✔ OS detection functional
✔ NSE scripts executed
✔ Automation scripts tested
✔ Results analyzed

---

# 🏁 Lab 09 Troubleshooting Complete

