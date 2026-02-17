# 🛠 Troubleshooting Guide  
## Lab 12 – Brute-Force and Credential Stuffing Attacks

This document outlines common issues encountered during the lab and verified solutions on:

Environment: Ubuntu 24.04.1 LTS  
Instance: toor@ip-172-31-10-188  

---

# 1️⃣ Hydra Issues

---

## ❌ Issue: "hydra: command not found"

### Cause:
Hydra is not installed or not in PATH.

### Solution:

```bash
sudo apt update
sudo apt install hydra -y
```

Verify installation:

```bash
hydra -h
```

---

## ❌ Issue: Hydra shows "connection refused"

### Cause:
Target service (FTP/HTTP) is not running.

### Solution:

Check service status:

```bash
sudo systemctl status vsftpd
sudo systemctl status apache2
```

Start services if stopped:

```bash
sudo systemctl start vsftpd
sudo systemctl start apache2
```

Verify ports:

```bash
sudo ss -tlnp | grep -E ':(21|80)'
```

Expected:

- Port 21 → FTP
- Port 80 → HTTP

---

## ❌ Issue: Hydra returns no valid passwords

### Possible Causes:
- Incorrect wordlists
- Wrong service type
- Incorrect HTTP path
- Credentials not actually valid

### Solutions:

✔ Verify correct service syntax:

FTP:
```bash
hydra -L userlist.txt -P passlist.txt 127.0.0.1 ftp
```

HTTP Basic:
```bash
hydra -L userlist.txt -P passlist.txt 127.0.0.1 http-get /protected/
```

✔ Confirm test credentials manually:

FTP:
```bash
ftp 127.0.0.1
```

HTTP:
```bash
curl -u webuser:password http://127.0.0.1/protected/
```

---

## ❌ Issue: Hydra very slow

### Cause:
Low thread count.

### Solution:

Increase tasks:

```bash
hydra -L userlist.txt -P passlist.txt -t 16 127.0.0.1 ftp
```

⚠ Note: High thread count may trigger detection systems.

---

# 2️⃣ FTP (vsftpd) Issues

---

## ❌ Issue: FTP login always fails

### Cause:
User not allowed in vsftpd configuration.

### Solution:

Check vsftpd config:

```bash
sudo nano /etc/vsftpd.conf
```

Ensure:

```
local_enable=YES
write_enable=YES
```

Restart:

```bash
sudo systemctl restart vsftpd
```

---

## ❌ Issue: vsftpd log file missing

Fail2Ban requires logs.

Check log path:

```bash
ls /var/log/vsftpd.log
```

If missing, enable logging in `/etc/vsftpd.conf`:

```
xferlog_enable=YES
log_ftp_protocol=YES
```

Restart:

```bash
sudo systemctl restart vsftpd
```

---

# 3️⃣ Apache HTTP Basic Auth Issues

---

## ❌ Issue: HTTP attack always returns 401

### Cause:
Authentication directory misconfigured.

### Verify Apache config:

```bash
sudo nano /etc/apache2/sites-available/000-default.conf
```

Ensure:

```
<Directory /var/www/html/protected>
    AuthType Basic
    AuthName "Protected Area"
    AuthUserFile /etc/apache2/.htpasswd
    Require valid-user
</Directory>
```

Restart Apache:

```bash
sudo systemctl restart apache2
```

---

## ❌ Issue: .htpasswd file not working

Verify file:

```bash
sudo cat /etc/apache2/.htpasswd
```

Recreate if necessary:

```bash
sudo htpasswd -cb /etc/apache2/.htpasswd webuser password
```

---

# 4️⃣ Credential Stuffing Script Issues

---

## ❌ Issue: Script not executable

### Solution:

```bash
chmod +x credential_stuffing.sh
```

---

## ❌ Issue: curl returns unexpected results

Test manually:

FTP:
```bash
curl --user admin:admin ftp://127.0.0.1
```

HTTP:
```bash
curl -u webuser:password http://127.0.0.1/protected/
```

Check HTTP status:

```bash
curl -o /dev/null -w "%{http_code}" -u webuser:password http://127.0.0.1/protected/
```

Expected:
200 → success  
401 → failed  

---

# 5️⃣ Fail2Ban Issues

---

## ❌ Issue: Fail2Ban not banning IP

Check service:

```bash
sudo systemctl status fail2ban
```

Check jail status:

```bash
sudo fail2ban-client status
```

Check specific jail:

```bash
sudo fail2ban-client status vsftpd
```

Verify logs:

```bash
sudo tail -f /var/log/fail2ban.log
```

---

## ❌ Issue: Incorrect log path

Verify in `/etc/fail2ban/jail.local`:

For FTP:
```
logpath = /var/log/vsftpd.log
```

For Apache:
```
logpath = /var/log/apache2/error.log
```

---

## ❌ Issue: IP remains banned

Unban manually:

```bash
sudo fail2ban-client set vsftpd unbanip 127.0.0.1
```

---

# 6️⃣ Script Permission Errors

---

## ❌ Issue: Permission denied when running scripts

### Solution:

```bash
chmod +x script_name.sh
```

Or run with:

```bash
bash script_name.sh
```

---

# 7️⃣ Rate Limiting Test Script Issues

---

## ❌ Issue: All attempts marked failed

This is expected behavior if using invalid credentials.

The script checks:
- FTP exit status
- HTTP 200 vs 401

Ensure correct logic if modifying script.

---

# 8️⃣ Performance & Environment Issues

---

## ❌ Issue: Too many connections error

Cause:
- Hydra thread count too high
- Fail2Ban triggered

Solution:
Lower threads:

```bash
hydra -t 4 ...
```

Or unban IP:

```bash
sudo fail2ban-client set vsftpd unbanip 127.0.0.1
```

---

# 9️⃣ General Debugging Commands

Useful commands during troubleshooting:

Check services:
```bash
sudo systemctl status vsftpd
sudo systemctl status apache2
```

Check listening ports:
```bash
sudo ss -tlnp
```

Check logs:
```bash
sudo tail -f /var/log/vsftpd.log
sudo tail -f /var/log/apache2/error.log
```

Check Fail2Ban:
```bash
sudo fail2ban-client status
```

---

# 🔎 Root Cause Patterns Observed in Lab

| Issue | Root Cause |
|-------|------------|
| Hydra failed | Service stopped |
| No results | Incorrect wordlists |
| HTTP brute-force fails | Wrong path |
| Fail2Ban not working | Incorrect log path |
| Script fails | Permission issue |

---

# 🏁 Final Troubleshooting Summary

Most lab failures are caused by:

✔ Services not running  
✔ Incorrect authentication configuration  
✔ Wrong Hydra syntax  
✔ Missing log files  
✔ Script permission issues  

Systematic debugging approach:

1. Verify service running  
2. Verify correct port open  
3. Test manually with curl  
4. Check logs  
5. Confirm Hydra syntax  
6. Validate Fail2Ban status  

---

# 🛡 Professional Practice Tip

Always:

- Test credentials manually first
- Confirm authentication mechanism
- Verify logging configuration
- Document errors before fixing
- Validate defensive controls after attack testing

---

Lab 12 troubleshooting guide complete.
