# 🛡 Lab 12: Brute-Force and Credential Stuffing Attacks  

---

## 📌 Overview

This lab demonstrates practical brute-force and credential stuffing attack methodologies using real-world tools in a controlled cloud lab environment.

Students will simulate:

- FTP brute-force attacks
- HTTP Basic Authentication brute-force
- Credential stuffing automation
- Rate limiting analysis
- Defensive implementation using Fail2Ban
- Professional reporting and documentation

This lab bridges offensive techniques with defensive countermeasures.

---

## 🎯 Objectives

✔ Understand brute-force attack methodology  
✔ Understand credential stuffing methodology  
✔ Use Hydra against FTP and HTTP services  
✔ Automate attacks using Bash scripting  
✔ Analyze compromised credentials  
✔ Implement defensive controls (Fail2Ban)  
✔ Generate structured security reports  

---

# 📚 Prerequisites

- Basic Linux command line proficiency
- Understanding of network protocols (HTTP, FTP)
- Familiarity with authentication mechanisms
- Basic Bash scripting knowledge
- Awareness of ethical hacking principles and legal boundaries


## 🖥 Lab Environment

**Operating System:** Ubuntu 24.04.1 LTS  
**Instance:** toor@ip-172-31-10-188  
**Services Used:**
- vsftpd (FTP)
- Apache2 (HTTP Basic Auth)
- Hydra
- Fail2Ban
- curl

---

## ⚙️ Phase 1: Environment Setup

### Services Installed

- vsftpd
- apache2
- apache2-utils
- curl
- fail2ban

### Ports Verified

- FTP → 21
- HTTP → 80

---

## 👥 Test Accounts Created

| Service | Username   | Password      | Weakness |
|----------|------------|--------------|----------|
| FTP      | admin      | admin        | Default credential |
| FTP      | testuser1  | password123  | Dictionary password |
| HTTP     | webuser    | password     | Weak dictionary password |

---

## 🔓 Phase 2: Brute-Force Attacks

### Tool Used: Hydra

Hydra is a parallelized login cracker supporting numerous protocols.

---

### 🔹 FTP Brute Force

```
hydra -L userlist.txt -P passlist.txt -v -f -o ftp_results.txt 127.0.0.1 ftp
```

### Successful Results

- admin : admin
- testuser1 : password123

---

### 🔹 HTTP Basic Authentication Attack

```
hydra -L userlist.txt -P passlist.txt -f -o http_results.txt 127.0.0.1 http-get /protected/
```

### Successful Results

- webuser : password
- admin : admin123

---

## 🔁 Phase 3: Credential Stuffing

Credential stuffing tests reused username:password pairs.

Custom Bash script tested credentials across:

- FTP using curl
- HTTP using curl with Basic Auth

### Successful Stuffing Results

- FTP: admin:admin
- FTP: testuser1:password123
- HTTP: webuser:password

---

## 📊 Phase 4: Attack Analysis

Scripts developed:

- brute_force.sh
- credential_stuffing.sh
- analyze_results.sh
- test_rate_limit.sh

Generated:
- Log files
- HTML security report
- Compromised account summary
- Password strength classification

---

## 🚨 Phase 5: Rate Limiting Test

Repeated 20 failed login attempts:

Result:
- No blocking observed
- No built-in rate limiting
- Services vulnerable to automated attack

---

## 🛡 Phase 6: Defensive Implementation

### Installed Fail2Ban

Configured jails for:
- vsftpd
- apache-auth

### Configuration

- maxretry = 3
- bantime = 600 seconds

---

### Defense Validation

After repeated failed attempts:

✔ IP 127.0.0.1 banned  
✔ FTP connections refused  
✔ Fail2Ban logging confirmed  

Defense successfully mitigated brute-force attempts.

---

## 📈 Findings Summary

| Metric | Value |
|--------|--------|
| Total Accounts Tested | 6 |
| Successful Compromises | 3 |
| Weak Password Rate | 50% |
| Rate Limiting Initially | Disabled |
| Rate Limiting After Defense | Enabled |

---

## 🔎 Security Weaknesses Identified

- Default credentials
- Weak dictionary passwords
- Password reuse
- No lockout mechanism
- No rate limiting
- No MFA

---

## 🛡 Defensive Recommendations

### Immediate

- Enforce minimum 12-character passwords
- Disable default accounts
- Enable account lockout

### Short-Term

- Deploy MFA
- Monitor authentication logs
- Enable intrusion detection

### Long-Term

- Implement Zero Trust
- Conduct periodic penetration testing
- Enforce password rotation

---

lab12-bruteforce-credential-stuffing/
│
├── README.md
├── interview_qna.md
├── troubleshooting.md
│
├── wordlists/
│   ├── userlist.txt
│   └── passlist.txt
│
├── scripts/
│   ├── brute_force.sh
│   ├── credential_stuffing.sh
│   ├── analyze_results.sh
│   └── test_rate_limit.sh
│
├── results/
│   ├── ftp_results.txt
│   ├── http_results.txt
│   ├── ftp_success.log
│   ├── http_success.log
│
├── defense/
│   ├── jail.local
│   └── fail2ban_status.txt
│
├── reports/
│   └── security_report.md



---
## 🧠 Real-World Relevance

This lab simulates real-world attack scenarios:

- Credential stuffing after data breach
- Default password exploitation
- Automated brute-force attempts
- Defense hardening with Fail2Ban

Used in:

- Incident Response
- Red Team Operations
- SOC Monitoring
- Penetration Testing
- Security Audits

---

## 🎓 Skills Developed

- Offensive authentication testing
- Hydra automation
- Bash scripting
- Credential analysis
- Rate limiting validation
- Defensive hardening
- Security documentation

---

## 🏁 Final Status

✔ FTP brute-forced  
✔ HTTP brute-forced  
✔ Credential stuffing successful  
✔ Attack automation built  
✔ HTML report generated  
✔ Fail2Ban configured  
✔ Rate limiting validated  
✔ Professional security report written  

Lab completed successfully.

---

## ⚖ Ethical Reminder

All testing performed:

✔ On controlled cloud environment  
✔ Authorized system  
✔ For educational purposes  

Unauthorized testing outside lab environments is illegal.

---

