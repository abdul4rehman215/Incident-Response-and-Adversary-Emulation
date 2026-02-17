# 🕵️‍♂️ LAB 04 — Network Forensics with Zeek

## 📌 Overview

This lab focuses on network forensic analysis using **Zeek (formerly Bro)** on Ubuntu 24.04.  
The objective was to capture live traffic, analyze protocol logs, create custom detection scripts, and generate forensic reports based on observed network behavior.

The lab simulates real-world attack patterns including:

- Suspicious DNS queries
- Malicious user-agents
- Port scanning behavior
- Long-duration connections
- High data transfer anomalies

Zeek was configured to log in JSON format and custom scripts were developed for detection engineering.

---

## 🎯 Objectives

By completing this lab, I achieved the following:

- Installed and configured Zeek 6.0.2
- Captured live network traffic from interface `ens5`
- Analyzed Zeek logs (conn.log, dns.log, http.log, ssl.log)
- Developed custom Zeek detection scripts
- Detected:
  - Suspicious user-agents
  - Malicious DNS queries
  - Port scanning activity
- Built automated forensic analysis tools (Python + Bash)
- Reconstructed network timeline
- Generated executive security reports

---

## 🖥 Lab Environment

| Component | Details |
|------------|----------|
| OS | Ubuntu 24.04.1 LTS |
| Hostname | ip-172-31-10-198 |
| User | toor |
| Interface | ens5 |
| Zeek Version | 6.0.2 |
| Logging Format | JSON |

---

## 📌 Prerequisites
- Basic understanding of networking concepts (TCP/IP, DNS, HTTP)
- Familiarity with Linux command line operations
- Knowledge of network security fundamentals
- Understanding of log analysis concepts
- Basic scripting knowledge (helpful but not required)

---

## 🛠 What Was Implemented

### 🔹 1. Zeek Installation & Configuration
- Zeek installed via apt
- JSON logging enabled
- Local monitoring configuration created

### 🔹 2. Traffic Capture
- Live traffic capture (60 seconds)
- HTTP and DNS test traffic generated
- Port scanning simulation executed

### 🔹 3. Detection Engineering
Custom Zeek scripts created for:

- Malicious domain detection
- Port scan detection
- Suspicious user-agent detection
- Long connection monitoring
- High data transfer detection

### 🔹 4. Forensic Automation
- Python forensic analyzer for Zeek logs
- Timeline reconstruction script
- Executive report generator
- Automated detection summary

---

## 🔍 Detection Results Summary

| Alert Type | Count |
|------------|--------|
| Suspicious User-Agent | 2 |
| DNS Suspicious | 1 |
| Port Scan | 1 |

All simulated malicious behaviors were successfully detected.

---

## 📊 Logs Generated

- conn.log
- dns.log
- http.log
- ssl.log
- malicious_activity.log
- network_timeline.txt
- zeek_security_report_*.txt

---

## 🧠 What I Learned

- How Zeek processes and logs live traffic
- Understanding Zeek log structure (JSON format)
- Writing custom detection scripts in Zeek scripting language
- Identifying Indicators of Compromise (IOCs)
- Correlating DNS, HTTP, and connection logs
- Detecting port scanning behavior using state tracking
- Automating forensic log analysis using Python
- Generating structured security reports

---

## 🌍 Real-World Relevance

Zeek is widely used in:

- SOC environments
- Threat hunting teams
- Incident response workflows
- Enterprise network monitoring
- Blue team operations
- Digital forensic investigations

This lab simulates:

- Brute-force reconnaissance
- Malicious scanning behavior
- Command-and-control detection
- Suspicious automation tools (sqlmap, nikto)
- DNS-based threat intelligence detection

---

## 🚨 Why This Matters

Network forensics provides:

- Real-time visibility into traffic
- Deep protocol-level inspection
- Evidence for security incidents
- Early detection of reconnaissance activity
- Identification of attacker tooling

Without network monitoring, attackers may operate undetected.

Zeek enables:

- Behavioral detection
- Custom detection engineering
- Structured forensic logging
- Long-term security visibility

---

## 🏁 Result

✔ Zeek successfully installed and configured  
✔ Live network traffic captured  
✔ Custom detection scripts executed  
✔ Suspicious behaviors detected  
✔ Timeline reconstruction completed  
✔ Forensic reports generated  
✔ Detection engineering validated  

---

## 🔐 Final Assessment

- Network Monitoring: ACTIVE  
- Detection Engineering: FUNCTIONAL  
- Simulated Attacks: DETECTED  
- Logs: VERIFIED  
- Forensic Reporting: COMPLETED  

---

# 🚀 Lab Successfully Completed — Network Forensics with Zeek
