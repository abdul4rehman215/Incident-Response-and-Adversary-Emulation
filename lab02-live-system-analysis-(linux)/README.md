# 🔍 Lab 02 — Live System Analysis (Linux)

## 📘 Overview

This lab focuses on performing live forensic analysis on a Linux system using native tools and `auditd`. The objective is to monitor system activity, analyze security events, correlate logs, and identify potential indicators of compromise (IOCs) in a controlled Ubuntu 24.04 environment.

Environment Used:
- OS: Ubuntu 24.04.1 LTS
- Hostname: ip-172-31-10-237
- User: toor
- Working Directory: /home/toor/forensic_analysis

---

## 🎯 Objectives

By completing this lab, I was able to:

- Configure and deploy `auditd` with custom forensic monitoring rules
- Perform live system forensic analysis
- Develop automated shell scripts for system investigation
- Analyze authentication, process, and network events
- Correlate logs across multiple sources
- Identify potential indicators of compromise
- Generate structured forensic reports

---

## 📌Prerequisites
• Basic Linux command line operations and file navigation
• Familiarity with text editors (nano or vim)
• Understanding of system logs and their locations in Linux
• Basic shell scripting concepts


## 🧰 Tools & Technologies Used

- auditd
- ausearch
- augenrules
- systemctl
- ss
- ip
- ps
- grep
- find
- awk
- Shell scripting (Bash)
- Ubuntu 24.04

---

## 🗂 Lab Structure

```
forensic_analysis/
├── system_info_collector.sh
├── audit_analyzer.sh
├── log_correlator.sh
├── threat_hunter.sh
├── system_analysis_*
├── audit_analysis_*
├── correlation_analysis_*
├── threat_hunting_*
└── final_report.txt
```

---

## 🛠 Tasks Performed (Overview)

### 1️⃣ Auditd Configuration
- Installed auditd and audispd-plugins
- Created custom forensic monitoring rules
- Monitored authentication, process execution, privilege escalation, cron jobs, and system configuration
- Verified rules using `auditctl -l`

### 2️⃣ Live System Snapshot Collection
- Collected system metadata
- Captured user activity and login records
- Extracted process information
- Gathered network connections and routing data
- Recorded filesystem and log modifications

### 3️⃣ Audit Log Analysis
- Searched audit logs using `ausearch`
- Filtered events by key
- Analyzed failed syscalls
- Generated event summaries

### 4️⃣ Log Correlation
- Correlated authentication logs
- Reviewed system logs
- Examined network activity
- Built timeline correlation
- Identified potential IOCs

### 5️⃣ Advanced Threat Hunting
- Reviewed persistence mechanisms
- Audited SUID/SGID files
- Analyzed process anomalies
- Investigated open ports and network indicators
- Generated structured threat report

### 6️⃣ Final Forensic Documentation
- Consolidated findings
- Summarized system state
- Documented potential risks
- Provided remediation recommendations

---

## 📊 Result

- Auditd successfully configured and active
- Forensic monitoring rules deployed and verified
- System snapshot collected successfully
- Audit log events analyzed
- No critical compromise indicators detected
- Threat hunting completed
- Professional forensic documentation generated

Final System Assessment:
- Auditd: ACTIVE
- System Stability: NORMAL
- Suspicious Persistence: NONE DETECTED
- Risk Level: LOW

---

## 🧠 What I Learned

- How Linux auditd works internally
- How to write structured forensic audit rules
- How to extract meaningful data from audit logs
- Importance of log correlation in investigations
- How to perform structured live system forensic analysis
- Threat hunting techniques on Linux systems
- Building automation scripts for incident response

---

## 🌍 Why This Matters

Live system analysis is critical in incident response. When a system is suspected of compromise, analysts must gather evidence without shutting it down. The ability to monitor system calls, correlate logs, and detect persistence mechanisms can prevent major breaches.

---

## 💼 Real-World Applications

- Security Operations Center (SOC) monitoring
- Linux incident response investigations
- Insider threat detection
- Privilege escalation monitoring
- Compliance auditing
- Threat hunting operations
- Digital forensic investigations

---

## 🔐 Real-World Relevance

Organizations rely heavily on Linux servers. Misconfigurations, privilege escalation attempts, and brute-force attacks are common. Auditd provides deep visibility into system behavior and is widely used in:

- Government systems
- Financial institutions
- Cloud environments
- Enterprise Linux infrastructure

Understanding how to configure and analyze audit logs is a critical skill for Blue Team professionals.

---

## 🏁 Conclusion

This lab demonstrated practical live system forensic analysis using native Linux tools and auditd. Through monitoring, correlation, and structured reporting, I successfully performed threat hunting and system analysis in a controlled environment.

The skills developed in this lab directly apply to real-world incident response and forensic investigations.

---
