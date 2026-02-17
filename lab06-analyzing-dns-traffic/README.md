# 🛡 LAB 06 — Analyzing DNS Traffic

---

## 📌 Lab Overview

This lab focuses on DNS traffic monitoring, forensic analysis, anomaly detection, and DNS tunneling identification using tcpdump and Python-based detection tools.

Students capture live DNS traffic, analyze PCAP files programmatically, detect suspicious domain behaviors, identify DGA domains, detect beaconing patterns, and implement DNS tunneling detection logic.

---

## 🎯 Objectives

By the end of this lab, I was able to:

- Capture DNS traffic using tcpdump
- Save and analyze DNS PCAP files
- Detect high-frequency DNS queries
- Identify suspicious keyword domains
- Detect DGA-like domains
- Detect DNS beaconing behavior
- Detect DNS tunneling indicators
- Create DNS behavioral baselines
- Generate structured forensic JSON reports
- Monitor DNS traffic in real-time

---

## 🖥 Environment

| Component | Value |
|-----------|--------|
| OS | Ubuntu 24.04 LTS |
| Host | ip-172-31-10-198 |
| User | toor |
| Interface | ens5 |
| Tools | tcpdump, scapy, Python3 |

---

## 📌 Prerequisites

- Basic understanding of DNS protocol and port 53
- Linux command-line proficiency
- Python programming fundamentals
- Familiarity with network packet analysis concepts

---

## 📂 Repository Structure

```

LAB_06_DNS_Analysis/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
└── scripts/
├── dns_analyzer.py
├── dns_monitor.py
├── dns_tunneling_detector.py
├── dns_baseline.py
└── dns_report.py

```

---

## 🔍 Core Capabilities Implemented

✔ DNS packet capture with tcpdump  
✔ Offline PCAP forensic analysis  
✔ Suspicious keyword detection  
✔ DGA detection logic  
✔ Frequency anomaly detection  
✔ Beaconing detection  
✔ DNS tunneling detection engine  
✔ Baseline anomaly comparison  
✔ Real-time DNS monitoring  
✔ Automated JSON forensic reporting  

---

## 🛡 Security Relevance

DNS is heavily abused in modern attacks:

- Command & Control (C2)
- Malware beaconing
- Data exfiltration
- DNS tunneling
- Domain Generation Algorithms (DGA)

This lab simulates real SOC detection workflows for DNS-based threats.

---

## ✅ Final Outcome

After completing this lab:

- DNS traffic can be captured and analyzed.
- Suspicious domains can be identified automatically.
- DNS tunneling attempts can be detected.
- Beaconing patterns can be recognized.
- Baseline-based anomaly detection is operational.
- Structured forensic reports can be generated.

---

## 🌍 Real-World Relevance

DNS is one of the most abused protocols in modern cyberattacks.  
Attackers frequently leverage DNS because it is:

- Almost always allowed through firewalls
- Rarely deeply inspected
- Essential for normal network operations

This lab simulates techniques used in:

- Security Operations Centers (SOC)
- Threat Hunting Teams
- Incident Response Units
- Malware Reverse Engineering Labs
- Enterprise Network Monitoring Environments

### 🔎 Real Threat Use Cases Covered

| Attack Type | Detection Method Implemented |
|------------|------------------------------|
| Command & Control (C2) | Frequency + Beaconing detection |
| DNS Tunneling | Subdomain entropy + TXT record abuse |
| DGA Domains | Consonant/Vowel ratio analysis |
| Data Exfiltration | Long query length + subdomain count |
| Malware Callbacks | Suspicious keyword detection |

---

## 🧠 Detection Techniques Implemented

### 1️⃣ Frequency-Based Detection
Identifies repeated DNS queries within short time windows (possible beaconing).

### 2️⃣ DGA Detection Logic
Detects algorithmically generated domains using:
- Long subdomain length
- High consonant-to-vowel ratio

### 3️⃣ Suspicious Keyword Matching
Flags domains containing:
- malware
- phishing
- trojan
- botnet

### 4️⃣ DNS Tunneling Indicators
Detects:
- High query volume
- Many unique subdomains
- Long average query length
- Excessive TXT record usage

### 5️⃣ Baseline Comparison Model
Creates a baseline of:
- Normal domains
- Typical query volume
- Common query types

Then compares new traffic to detect:
- New domains
- Volume spikes
- Unusual query types

---

## 📊 Skills Demonstrated

- Network packet capture
- PCAP forensic analysis
- DNS protocol understanding
- Behavioral anomaly detection
- Python-based packet parsing
- Threat detection engineering
- IOC identification
- SOC-style monitoring implementation
- Automated report generation
- Real-time threat monitoring

---

## 🔐 Final Security Assessment

| Component | Status |
|-----------|--------|
| DNS Packet Capture | ✅ Operational |
| Offline Analysis | ✅ Functional |
| DGA Detection | ✅ Working |
| Beaconing Detection | ✅ Working |
| DNS Tunneling Detection | ✅ Working |
| Baseline Engine | ✅ Functional |
| JSON Reporting | ✅ Structured |
| Real-Time Monitoring | ✅ Operational |

---

## 📈 Enterprise-Level Applications

This workflow directly maps to:

- SIEM integration pipelines
- DNS security monitoring appliances
- EDR DNS telemetry analysis
- Threat Intelligence enrichment
- SOC alert triage automation

---

## 🚀 Lab Completion Status

Detection Phase: ✅ Complete  
Analysis Phase: ✅ Complete  
Threat Hunting Phase: ✅ Complete  
Automation Phase: ✅ Complete  
Reporting Phase: ✅ Complete  

---

## 🛡 **DNS Threat Detection Framework Successfully Implemented**

# 🎯 **LAB 06 COMPLETED SUCCESSFULLY**
