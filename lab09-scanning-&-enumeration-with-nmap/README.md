# 🛡 Lab 09 – Scanning & Enumeration with Nmap

---

# 📖 Overview

This lab focuses on mastering **network scanning and enumeration** using Nmap.  
It covers host discovery, port scanning, service detection, OS fingerprinting, NSE scripts, and automation using Bash scripting.

All activities were performed in a controlled cloud-based Ubuntu environment for authorized testing purposes.

---

# 🎯 Objectives

By completing this lab, I was able to:

- Understand the fundamentals of network scanning and enumeration
- Perform host discovery scans
- Conduct TCP and UDP scans
- Execute SYN stealth scans
- Identify open ports and services
- Perform OS fingerprinting
- Use Nmap Scripting Engine (NSE)
- Automate scanning using Bash scripts
- Build a multi-target scanning framework
- Analyze scan results programmatically
- Apply scanning techniques in IR and adversary emulation scenarios

---

# 📚 Prerequisites

- Basic understanding of networking concepts (IP addresses, ports, protocols)
- Familiarity with Linux command line interface
- Basic knowledge of Bash scripting fundamentals
- Understanding of TCP/IP protocol suite
- Knowledge of common network services and their default ports

---

# 🖥 Lab Environment

| Component | Value |
|------------|--------|
| OS | Ubuntu 24.04.1 LTS |
| User | toor |
| Instance | ip-172-31-10-233 |
| Interface | ens5 |
| Scanner | Nmap 7.94 |

---

# 📂 Repository Structure

```
lab09-nmap-scanning/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
└── scripts/
    ├── nmap_scanner.sh
    ├── advanced_nmap_scanner.sh
    └── analyze_results.sh
```

---

# ⚙ Tasks Performed

## 1️⃣ Network Scanning Fundamentals
- Verified Nmap installation
- Checked network interface
- Identified IP configuration

## 2️⃣ Host Discovery
- Ping scan (-sn)
- ARP scan (-PR)
- Target list creation

## 3️⃣ Port Scanning
- Default scan
- Specific ports scan
- Range scan
- Full 65535 port scan

## 4️⃣ Advanced Scanning
- SYN stealth scan (-sS)
- UDP scan (-sU)
- Aggressive scan (-A)

## 5️⃣ Service & OS Detection
- Version detection (-sV)
- OS fingerprinting (-O)
- High-intensity detection

## 6️⃣ NSE Script Usage
- Default scripts (-sC)
- Vulnerability scripts (--script vuln)
- HTTP enumeration scripts

## 7️⃣ Automation
- Built automated scanner
- Created multi-target framework
- Implemented result analyzer
- Generated structured reports

---

# 📊 Key Findings

Open ports identified:
- 22/tcp (SSH)
- 80/tcp (HTTP)
- 631/tcp (IPP)
- 8080/tcp (HTTP Proxy)

Service versions:
- OpenSSH 9.6p1
- Apache 2.4.58
- CUPS 2.4

OS detected:
- Linux Kernel 5.x

No active vulnerabilities detected in lab environment.

---

# 🔎 Real-World Relevance

This lab directly simulates reconnaissance techniques used by:

- Red Team Operators
- Adversaries during initial access
- Incident Response teams
- Threat hunters

Nmap is widely used in:

- Security assessments
- Breach investigations
- Attack surface mapping
- Vulnerability validation

Understanding scanning techniques improves both offensive and defensive security posture.

---

# 🧠 Skills Developed

- Network reconnaissance
- TCP/UDP scanning techniques
- Service enumeration
- OS fingerprinting
- NSE scripting usage
- Bash automation
- Multi-target scanning
- Structured result analysis

---

# 🛡 Security & Ethical Considerations

All scans were performed:

✔ On localhost  
✔ In authorized lab environment  
✔ Without targeting external systems  
✔ Using controlled scan intensity  

Ethical scanning principles were followed strictly.

---

# 🏁 Conclusion

In this lab, I successfully:

✔ Verified Nmap installation  
✔ Conducted manual scanning techniques  
✔ Used advanced detection options  
✔ Automated scanning workflows  
✔ Built scalable multi-target scanner  
✔ Generated structured reports  
✔ Analyzed findings programmatically  

This lab strengthens my foundation in:

- Incident Response
- Adversary Emulation
- Red Team Reconnaissance
- Network Security Assessment

---
