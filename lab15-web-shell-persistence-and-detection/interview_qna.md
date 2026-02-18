# 🎤 Interview QNA – Lab 15: Web Shell Persistence and Detection

---

## 1️⃣ What is a Web Shell?

A web shell is a malicious script uploaded to a web server that allows attackers to execute arbitrary system commands remotely via HTTP requests.

Web shells are typically written in:
- PHP
- ASP
- JSP
- Python

They are commonly used for:
- Command execution
- File manipulation
- Database access
- Lateral movement
- Persistence after exploitation

---

## 2️⃣ Why Are Web Shells Dangerous?

Web shells provide attackers with:

- Remote command execution capability
- Privilege escalation opportunities
- Persistent backdoor access
- Ability to modify website content
- Access to sensitive configuration files
- Potential pivoting into internal networks

Because they operate through legitimate web servers, they often bypass traditional perimeter security controls.

---

## 3️⃣ What PHP Functions Are Commonly Used in Web Shells?

Common dangerous PHP functions include:

- `system()`
- `exec()`
- `shell_exec()`
- `passthru()`
- `eval()`
- `base64_decode()`

These functions allow attackers to:
- Execute operating system commands
- Decode obfuscated payloads
- Dynamically execute arbitrary code

---

## 4️⃣ What Is Persistence in the Context of Web Shells?

Persistence refers to maintaining unauthorized access to a system after initial compromise.

Attackers may:
- Hide shells in upload directories
- Use stealth filenames (e.g., image.php)
- Place shells in hidden directories
- Embed backdoors in legitimate configuration files
- Protect shells with passwords or sessions

Persistence ensures continued access even if the original vulnerability is patched.

---

## 5️⃣ What Detection Techniques Were Used in This Lab?

### File-Based Detection

- Recursive scanning of `.php` files
- Searching for suspicious functions using grep
- Checking insecure file permissions (777)
- Identifying encoded payload indicators (base64_decode)

### Log-Based Detection

- Searching Apache logs for:
  - `cmd=`
  - `exec=`
  - `x=`
- Identifying suspicious user agents (curl, wget, python)
- Detecting POST requests to PHP files
- Identifying high-frequency requests

### Real-Time Monitoring

- Using `tail -F` for log streaming
- Using `inotifywait` for filesystem monitoring
- Generating alerts in real time

---

## 6️⃣ Why Is Log Analysis Important in Incident Response?

Logs provide:

- Evidence of attacker activity
- Timeline of compromise
- IP address of attacker
- Commands executed
- Persistence attempts
- Post-exploitation behavior

Without logs, attribution and forensic reconstruction become extremely difficult.

---

## 7️⃣ What Is Quarantine in Incident Response?

Quarantine is the process of:

- Isolating malicious files
- Backing them up for forensic analysis
- Removing them from active execution paths

In this lab:
- Suspicious files were copied to a backup directory
- Moved into a quarantine directory
- Permissions were hardened afterward

This approach prevents evidence destruction while eliminating active threats.

---

## 8️⃣ Why Disable PHP Execution in Upload Directories?

Upload directories are high-risk areas because:

- Users can upload files
- Attackers often exploit upload vulnerabilities
- Web shells are frequently disguised as images

Adding `.htaccess` with:
```php_flag engine off```

Prevents execution of PHP files in that directory.

This is a common hardening technique in production environments.

---

## 9️⃣ What Is Real-Time Monitoring and Why Is It Important?

Real-time monitoring allows immediate detection of:

- Suspicious HTTP requests
- Creation or modification of PHP files
- Command injection attempts

Benefits:

- Reduced dwell time
- Faster containment
- Early detection before full compromise

---

## 🔟 How Would You Harden a Production Web Server Against Web Shells?

Recommended measures:

- Disable dangerous PHP functions in php.ini:
  - disable_functions = system, exec, shell_exec, passthru

- Implement Web Application Firewall (WAF)
- Enable ModSecurity
- Restrict file upload types
- Monitor logs centrally
- Use file integrity monitoring
- Apply strict file permissions
- Separate application and upload directories
- Use least privilege principle

---

## 1️⃣1️⃣ What Is Defense-in-Depth in This Context?

Defense-in-depth means implementing multiple layers of protection:

1. Secure coding practices
2. File permission hardening
3. Log monitoring
4. File scanning
5. Real-time alerting
6. Automated remediation

Even if one control fails, others provide protection.

---

## 1️⃣2️⃣ How Does Automation Improve Incident Response?

Automation:

- Reduces manual effort
- Speeds up detection
- Enables consistent remediation
- Minimizes human error
- Allows scalability across multiple servers

In this lab, automation was implemented via:

- Detection scripts
- Removal scripts
- Verification scripts
- Monitoring dashboard

---

## 1️⃣3️⃣ What Are Indicators of Compromise (IoCs) for Web Shells?

Examples:

- Suspicious parameters in logs (cmd=, exec=)
- Unusual POST requests
- Repeated curl/wget user agents
- Unknown PHP files in uploads
- Files containing eval() or system()
- Abnormal file permissions (777)
- Hidden directories containing executable scripts

---

## 1️⃣4️⃣ How Would You Perform Forensic Analysis on a Web Shell?

Steps:

1. Preserve the file (backup before removal)
2. Calculate file hash (sha256sum)
3. Examine obfuscation (base64_decode)
4. Review logs for execution history
5. Identify attacker IP addresses
6. Determine lateral movement attempts
7. Review system logs
8. Identify persistence mechanisms

---

## 1️⃣5️⃣ What Real-World Roles Require This Knowledge?

- SOC Analyst
- Incident Responder
- Blue Team Analyst
- Threat Hunter
- Web Security Engineer
- DevSecOps Engineer
- Cloud Security Engineer

---

# 🏁 Final Interview Summary

This lab demonstrates:

- Offensive persistence techniques
- Defensive detection engineering
- Automated remediation workflows
- Real-time monitoring implementation
- Practical incident response methodology

The ability to detect and respond to web shells is a critical defensive skill in modern web security operations.

