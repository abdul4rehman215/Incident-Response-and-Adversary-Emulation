# 🛡 LAB 05 — Incident Detection with Suricata

## 📌 Overview

This lab demonstrates practical deployment and operation of **Suricata Network Intrusion Detection System (NIDS)** in a controlled Linux environment.

Suricata was installed, configured, and enhanced with both community and custom detection rules.  
Realistic attack simulations were generated to validate detection capabilities.

The lab workflow replicates real-world SOC operations including:

- Threat detection
- Log analysis
- Alert correlation
- Incident response automation
- Rule optimization
- Performance monitoring

---

## 🎯 Objectives

By completing this lab, the following skills were demonstrated:

- Installation and configuration of Suricata IDS
- Interface monitoring configuration
- Rule management and rule updates
- Creation of custom detection rules
- Attack simulation and traffic generation
- JSON log parsing and alert analysis
- Automated incident response scripting
- Performance monitoring and tuning

---

## 🖥 Lab Environment

| Component | Value |
|-----------|--------|
| OS | Ubuntu 24.04 LTS |
| User | toor |
| Hostname | ip-172-31-10-247 |
| Interface | ens5 |
| Suricata Version | 6.0.10 |

---

## 📌 Prerequisites

- Basic understanding of Linux command line operations
- Fundamental knowledge of networking concepts (TCP/IP, ports, protocols)
- Basic familiarity with log file analysis
- Understanding of cybersecurity concepts like intrusion detection
- Knowledge of text editors like nano or vim

---

## 📂 Detection Components Implemented

### Default & Emerging Threat Rules
Updated and integrated community rule sets.

### Custom Lab Rules
- ICMP Detection
- Suspicious HTTP Parameter Detection
- SSH Brute Force Detection
- DNS Suspicious Query Detection
- Large File Download Detection

### Advanced Custom Rules
- Advanced SSH brute-force
- Suspicious User-Agent detection
- Data exfiltration detection
- DNS-over-HTTPS detection
- Cryptocurrency mining detection
- File upload detection

---

## 🚨 Security Incidents Detected

During testing and simulation, the following were successfully detected:

- ICMP scanning
- Suspicious HTTP parameters
- Suspicious user-agent strings
- SSH brute force attempts
- DNS queries to suspicious domains
- File upload attempts
- Data exfiltration attempts
- Port scanning
- Nmap scripting engine detection

---

## 🔍 Automation & Tooling Built

- Log analyzer script
- Real-time alert monitoring
- Attack simulation tool
- Incident response automation
- Performance monitor
- Advanced Python parser
- Alert dashboard
- Rule performance analyzer

---

## 📊 Detection Summary (Sample)

| Alert Type | Count |
|------------|-------|
| ICMP Ping Detected | 7 |
| Suspicious HTTP Request | 5 |
| Suspicious DNS Query | 4 |
| Potential SSH Brute Force | 3 |
| Advanced Rule Alerts | 6 |

---

## 🏁 Final Status

Detection Phase: ✅ Complete  
Analysis Phase: ✅ Complete  
Incident Response: ✅ Automated  
Performance Tuning: ✅ Verified  
Rule Optimization: ✅ Validated  

---

## 💡 Real-World Relevance

This lab simulates:

- SOC alert triage
- IDS tuning workflows
- Threat detection lifecycle
- Incident evidence collection
- Rule optimization and coverage validation

The structure mirrors real enterprise IDS deployments.

---

## Repository Structure
```
└── LAB-05-Incident-Detection-with-Suricata/
    ├── README.md
    ├── commands.sh
    ├── rules/
    │   ├── lab-rules.rules
    │   └── advanced-rules.rules
    ├── scripts/
    │   ├── suricata_analyzer.sh
    │   ├── monitor_alerts.sh
    │   ├── attack_simulator.sh
    │   ├── incident_response.sh
    │   ├── performance_monitor.sh
    │   ├── rule_performance.sh
    │   ├── advanced_parser.py
    │   └── alert_dashboard.sh
    ├── outputs
    ├── reports/
    │   └── incident_summary.txt
    ├── interview_qna.md
    └── troubleshooting.md
```


## 📌 Conclusion

Suricata was successfully deployed as a fully operational intrusion detection system.

Custom rule engineering, automated log parsing, incident response scripting, and performance monitoring demonstrated a complete IDS lifecycle implementation.

This lab validates hands-on competency in:

- IDS deployment
- Threat detection
- Security automation
- SOC-level analysis

---

