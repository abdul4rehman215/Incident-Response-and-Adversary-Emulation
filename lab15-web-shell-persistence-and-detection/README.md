# 🛡 Lab 15 – Web Shell Persistence and Detection

---

## 📌 Overview

This lab demonstrates how web shells are deployed for persistence in web environments and how defenders can detect, monitor, and remediate them using file analysis, log analysis, and automation scripts.

The environment simulates real-world adversary behavior against an Apache/PHP application hosted on Ubuntu 24.04 LTS.

---

## 🎯 Objectives

By the end of this lab, students will be able to:

- Understand web shell concepts and their role in persistence attacks
- Deploy different types of web shells in a controlled environment
- Create detection scripts using file-based analysis
- Analyze Apache logs for suspicious activity
- Implement automated removal and quarantine mechanisms
- Develop real-time monitoring solutions
- Build a lightweight monitoring dashboard

---

## 📚 Prerequisites

- Basic Linux command line proficiency  
- Understanding of Apache web server  
- Familiarity with PHP syntax  
- Basic Bash scripting knowledge  

---

## 🖥 Lab Environment

**Operating System:** Ubuntu 24.04.1 LTS (Noble Numbat)  
**Environment:** Alnafi EC2 Cloud Lab  
**User:** toor  
**Instance:** ip-172-31-10-248  

Installed Components:

- Apache2
- PHP 8.x
- grep, awk, sed
- inotify-tools
- nano editor

---

## 🧪 Environment Verification

System version verified using:

`
cat /etc/os-release
`

Current working directory verified using:

`
pwd
`

---

# 🧩 Lab Tasks Overview

---

## Task 1 – Environment Setup

- Configure and enable Apache
- Create vulnerable test web application
- Create legitimate PHP pages
- Configure proper permissions

---

## Task 2 – Web Shell Deployment

- Deploy basic command execution shell
- Deploy password-protected advanced shell
- Deploy stealth backdoor using eval()
- Hide shells in multiple directories (uploads, hidden folders)

---

## Task 3 – Generate Malicious Activity

- Execute shell commands via curl
- Generate Apache log entries
- Simulate attacker behavior

---

## Task 4 – Detection Engineering

- Develop file-based web shell detection script
- Develop Apache log analysis script
- Implement real-time monitoring using inotify
- Generate alert logging

---

## Task 5 – Removal & Remediation

- Develop automated web shell remover
- Create quarantine and backup mechanism
- Harden file and directory permissions
- Disable PHP execution in uploads directory
- Verify cleanup integrity

---

## Task 6 – Monitoring Dashboard

- Create web shell monitoring dashboard script
- Display:
  - Total PHP files
  - Suspicious function count
  - Web request statistics
  - Top IP addresses
  - Recent alerts

---

# 📂 Repository Structure

```
lab15-web-shell-persistence-detection/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
└── scripts/
    ├── index.php
    ├── about.php
    ├── contact.php
    ├── shell_basic.php
    ├── shell_advanced.php
    ├── config.php
    ├── webshell_detector.sh
    ├── log_analyzer.sh
    ├── realtime_monitor.sh
    ├── webshell_remover.sh
    ├── verify_cleanup.sh
    └── webshell_dashboard.sh
```

---

# 🔐 Security Relevance

Web shells are one of the most common persistence mechanisms used after exploitation of:

- File upload vulnerabilities
- Remote Code Execution (RCE)
- CMS/plugin exploitation
- Local File Inclusion (LFI)

This lab focuses on defensive detection, response automation, and monitoring techniques used in real-world incident response scenarios.

---

# 🌍 Real-World Relevance

Web shells are one of the most common post-exploitation persistence techniques used by attackers after exploiting:
- File upload vulnerabilities
- RCE vulnerabilities
- LFI vulnerabilities
- CMS plugin exploits

### Security teams must implement: 
- Continuous scanning
- Log monitoring
- File integrity monitoring
- Automated quarantine
- Permission hardening

---

# 🎓 What I Learned

- How attackers deploy stealth web shells
- How to simulate real malicious traffic
- How to automate detection and response
- How to integrate monitoring into a response workflow
- How to verify remediation success

### Understanding web shell detection is essential for:
- Incident response
- Threat hunting
- Web server hardening
- Continuous monitoring
- Regular scanning, monitoring, and permission hardening significantly reduce persistence risks in production environments.

---

# 🏁 Conclusion

This lab provided hands-on experience with:
- Web shell persistence mechanisms
- File-based detection techniques
- Log-based threat identification
- Automated removal and quarantine
- Real-time monitoring and dashboard visibility

In this lab, a complete web shell lifecycle was simulated:
1. Deployment
2. Detection
3. Monitoring
4. Removal
5. Verification
6. Continuous visibility
This structured approach reflects real-world incident response workflows and strengthens defensive web server security posture.

---

# 🔐 Key Takeaways

- Web shells often rely on system(), exec(), eval()
- Detection requires file + log analysis
- Automation reduces response time
- Real-time alerts improve security posture
- Proper permissions prevent execution abuse

---

# 📌 Result
A complete web shell detection, monitoring, remediation, and verification ecosystem was built and tested successfully within a controlled Apache/PHP environment.
