# 🛠 Troubleshooting Guide – Lab 15: Web Shell Persistence and Detection

---

# 1️⃣ Apache Not Starting

## ❗ Issue

Apache service fails to start or shows inactive status.

## 🔍 Symptoms

- `systemctl status apache2` shows failed
- Website not accessible via browser or curl
- Port 80 not responding

## 🧪 Diagnosis

Check service status:

```bash
sudo systemctl status apache2
````

Check if port 80 is already in use:

```bash
sudo netstat -tlnp | grep :80
```

Or:

```bash
sudo ss -tlnp | grep :80
```

Check Apache logs:

```bash
sudo journalctl -xe
```

## ✅ Solution

Restart Apache:

```bash
sudo systemctl restart apache2
```

If another service is using port 80:

* Stop conflicting service
* Or change Apache port in `/etc/apache2/ports.conf`

---

# 2️⃣ Permission Denied Errors in /var/www/html

## ❗ Issue

Unable to create or modify files inside web directory.

## 🔍 Symptoms

* "Permission denied"
* Cannot create PHP files
* Shell scripts fail to scan

## 🧪 Diagnosis

Check directory ownership:

```bash
ls -la /var/www/html
```

Check user identity:

```bash
whoami
```

## ✅ Solution

Use sudo for administrative operations:

```bash
sudo nano /var/www/html/testapp/file.php
```

Correct ownership:

```bash
sudo chown -R www-data:www-data /var/www/html/testapp
```

Correct permissions:

```bash
sudo chmod -R 755 /var/www/html/testapp
```

---

# 3️⃣ Web Shell Not Executing

## ❗ Issue

Web shell returns blank page or does not execute commands.

## 🔍 Symptoms

* No output from curl
* 403 Forbidden error
* 500 Internal Server Error

## 🧪 Diagnosis

Check Apache error log:

```bash
sudo tail -f /var/log/apache2/error.log
```

Verify PHP is installed:

```bash
php -v
```

Check file permissions:

```bash
ls -la /var/www/html/testapp
```

## ✅ Solution

Ensure PHP module is enabled:

```bash
sudo a2enmod php
sudo systemctl restart apache2
```

Verify correct file permissions:

```bash
sudo chmod 644 *.php
```

---

# 4️⃣ Detection Script Not Detecting Web Shells

## ❗ Issue

webshell_detector.sh does not identify suspicious files.

## 🔍 Symptoms

* Scan completes with no alerts
* Known shell files still exist

## 🧪 Diagnosis

Verify web shell files exist:

```bash
ls -la /var/www/html/testapp
```

Test grep manually:

```bash
grep -E "system" /var/www/html/testapp/*.php
```

Check script permissions:

```bash
ls -la ~/webshell_detector.sh
```

## ✅ Solution

Make script executable:

```bash
chmod +x ~/webshell_detector.sh
```

Ensure suspicious functions list includes relevant keywords.

Modify pattern if needed:

```bash
SUSPICIOUS_FUNCTIONS=("system" "exec" "eval")
```

---

# 5️⃣ Log Analyzer Not Showing Suspicious Activity

## ❗ Issue

log_analyzer.sh returns no suspicious entries.

## 🔍 Symptoms

* No cmd= entries detected
* No POST activity visible

## 🧪 Diagnosis

Generate test traffic:

```bash
curl "http://localhost/testapp/shell_basic.php?cmd=whoami"
```

Verify access log exists:

```bash
ls -la /var/log/apache2/
```

Check recent log entries:

```bash
sudo tail -20 /var/log/apache2/access.log
```

## ✅ Solution

Ensure Apache logging is enabled.

Restart Apache:

```bash
sudo systemctl restart apache2
```

Confirm log file path in script matches system configuration.

---

# 6️⃣ Real-Time Monitor Not Generating Alerts

## ❗ Issue

realtime_monitor.sh runs but does not display alerts.

## 🔍 Symptoms

* No alert messages
* webshell_alerts.log remains empty

## 🧪 Diagnosis

Verify inotify-tools installation:

```bash
which inotifywait
```

Check access log path:

```bash
ls -la /var/log/apache2/access.log
```

Manually trigger suspicious request:

```bash
curl "http://localhost/testapp/shell_basic.php?cmd=id"
```

## ✅ Solution

Install inotify tools:

```bash
sudo apt install -y inotify-tools
```

Ensure script is executable:

```bash
chmod +x ~/realtime_monitor.sh
```

Run script in foreground:

```bash
./realtime_monitor.sh
```

---

# 7️⃣ Web Shell Remover Accidentally Quarantines Legitimate Files

## ❗ Issue

Legitimate PHP files are quarantined.

## 🔍 Cause

File contains:

* system()
* eval()
* base64_decode()

Even if used legitimately.

## 🧪 Diagnosis

Review file content manually:

```bash
cat /path/to/file.php
```

## ✅ Solution

Enhance detection logic with:

* Whitelisting known files
* More precise regex patterns
* Code context inspection

Example whitelist approach:

```bash
if [[ "$file" != *"index.php"* ]]; then
```

---

# 8️⃣ .htaccess Not Blocking PHP Execution

## ❗ Issue

PHP files in uploads directory still execute.

## 🔍 Diagnosis

Verify .htaccess exists:

```bash
ls -la /var/www/html/testapp/uploads
```

Check Apache configuration:

```bash
sudo nano /etc/apache2/apache2.conf
```

Ensure:

```
AllowOverride All
```

Is enabled for web root.

## ✅ Solution

Enable overrides:

```bash
sudo a2enmod rewrite
sudo systemctl restart apache2
```

---

# 9️⃣ Dashboard Showing Incorrect Counts

## ❗ Issue

Dashboard statistics appear incorrect.

## 🔍 Diagnosis

Verify PHP count manually:

```bash
find /var/www/html -name "*.php"
```

Check log request count:

```bash
wc -l /var/log/apache2/access.log
```

## ✅ Solution

Ensure:

* Correct log file path
* No rotated logs interfering
* Permissions allow reading

---

# 🔟 Excessive False Positives in Detection

## ❗ Issue

Many legitimate files flagged as suspicious.

## 🔍 Cause

Generic pattern matching (grep) may match safe code.

## ✅ Solution

Improve detection by:

* Checking for suspicious parameter usage
* Looking for user input variables
* Combining multiple conditions

Example:

```bash
grep -E "system\s*\(\s*\$_(GET|POST|REQUEST)"
```

---

# 🧠 Preventive Best Practices

* Disable dangerous PHP functions in php.ini
* Restrict file upload extensions
* Implement WAF
* Centralize logs
* Use file integrity monitoring
* Apply least privilege permissions
* Monitor unusual user agents
* Perform regular security audits

---

# 🏁 Final Troubleshooting Summary

Common failures in web shell detection environments usually relate to:

* Permission misconfigurations
* Log misalignment
* Disabled Apache modules
* Incorrect script execution rights
* Overly broad pattern matching

Systematic validation and verification at each step ensures stable detection, monitoring, and remediation workflows.

