# 🛠 Troubleshooting Guide: Lab 10 – SMB Scanning with Enum4Linux

---

## 1️⃣ Enum4Linux Not Installed

### ❌ Problem:
Running `enum4linux` returns:
```

command not found

````

### 🔍 Cause:
Enum4Linux is not installed on the system.

### ✅ Solution:

```bash
sudo apt update
sudo apt install enum4linux -y
````

Verify installation:

```bash
enum4linux --help
```

---

## 2️⃣ SMB Service (Samba) Not Running

### ❌ Problem:

Enumeration returns connection errors or no response.

Example:

```
Connection refused
NT_STATUS_CONNECTION_REFUSED
```

### 🔍 Cause:

Samba service (`smbd`) is not running.

### ✅ Solution:

Check service status:

```bash
sudo systemctl status smbd
```

Start service:

```bash
sudo systemctl start smbd
```

Enable on boot:

```bash
sudo systemctl enable smbd
```

Verify port 445:

```bash
sudo ss -tlnp | grep 445
```

---

## 3️⃣ Samba Configuration Errors

### ❌ Problem:

Samba fails to start after editing `/etc/samba/smb.conf`.

### 🔍 Cause:

Syntax errors in configuration file.

### ✅ Solution:

Validate configuration:

```bash
sudo testparm
```

Fix errors shown in output.

Restart service:

```bash
sudo systemctl restart smbd
```

---

## 4️⃣ Permission Denied on Share

### ❌ Problem:

Users cannot access the test share.

### 🔍 Cause:

Incorrect directory ownership or permissions.

### ✅ Solution:

Check permissions:

```bash
ls -ld /srv/samba/testshare
```

Fix permissions:

```bash
sudo chmod 755 /srv/samba/testshare
sudo chown nobody:nogroup /srv/samba/testshare
```

Restart Samba:

```bash
sudo systemctl restart smbd
```

---

## 5️⃣ Enum4Linux Timeout Errors

### ❌ Problem:

Enumeration hangs or times out.

### 🔍 Cause:

* Firewall blocking port 445
* Network filtering
* Thread overload

### ✅ Solution:

Check firewall:

```bash
sudo ufw status
```

Allow SMB:

```bash
sudo ufw allow 445/tcp
```

Reduce threads in Python scanner:

```bash
python3 smb_network_scanner.py 127.0.0.1 -t 5
```

---

## 6️⃣ Python Script Execution Errors

### ❌ Problem:

Scripts fail with module errors.

Example:

```
ModuleNotFoundError
```

### 🔍 Cause:

Missing Python libraries.

### ✅ Solution:

Verify Python version:

```bash
python3 --version
```

Install missing modules:

```bash
pip3 install ipaddress
```

Verify imports:

```bash
python3 -c "import subprocess, threading, json"
```

---

## 7️⃣ SMB Port 445 Closed

### ❌ Problem:

Python scanner reports:

```
SMB port 445 closed
```

### 🔍 Cause:

* Samba not running
* Firewall blocking traffic
* Wrong target IP

### ✅ Solution:

Verify service:

```bash
sudo systemctl status smbd
```

Check listening ports:

```bash
sudo ss -tlnp | grep 445
```

Test manually:

```bash
nmap -p 445 127.0.0.1
```

---

## 8️⃣ Enum4Linux Shows No Users

### ❌ Problem:

`enum4linux -U` returns no users.

### 🔍 Cause:

* Anonymous enumeration disabled
* No valid Samba users configured

### ✅ Solution:

Add Samba users:

```bash
sudo smbpasswd -a testuser1
```

Enable null session if required (lab environment only):

```
map to guest = bad user
```

Restart service:

```bash
sudo systemctl restart smbd
```

---

## 9️⃣ Advanced Analyzer Shows No Shares

### ❌ Problem:

Analyzer output shows 0 shares.

### 🔍 Cause:

Share enumeration parsing mismatch or no shares configured.

### ✅ Solution:

Verify share exists:

```bash
enum4linux -S 127.0.0.1
```

Ensure smb.conf contains:

```
[testshare]
 path = /srv/samba/testshare
 browsable = yes
 writable = yes
 valid users = testuser1, testuser2
```

Restart service:

```bash
sudo systemctl restart smbd
```

---

## 🔟 High CPU Usage During Multi-Thread Scan

### ❌ Problem:

System becomes slow during multi-target scan.

### 🔍 Cause:

Too many concurrent threads.

### ✅ Solution:

Lower thread count:

```bash
python3 smb_network_scanner.py targets.txt -t 3
```

Monitor usage:

```bash
top
```

---

# 🔐 Security Considerations During Troubleshooting

While troubleshooting SMB enumeration:

* Never expose SMB (445) to the public internet
* Avoid enabling null sessions in production
* Always test in authorized lab environments
* Log all enumeration activities
* Follow responsible disclosure policies

---

# 🏁 Troubleshooting Summary

This lab validated:

✔ Samba service configuration
✔ SMB share permissions
✔ Enum4Linux functionality
✔ Bash automation execution
✔ Python multi-threaded scanner stability
✔ Risk analysis reporting
✔ Controlled and authorized enumeration

Proper troubleshooting ensures reliable enumeration and accurate security assessment results.
