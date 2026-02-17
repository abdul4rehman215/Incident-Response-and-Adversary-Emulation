# 🔐 Lab 01 – Incident Response Lifecycle

---

## 🖥 Environment

- **OS:** Ubuntu 24.04.1 LTS (Alnafi Cloud – EC2)
- **Hostname:** ip-172-31-10-214
- **User:** toor
- **Shell:** Bash

---

## 🎯 Objectives

- Understand the core phases of the Incident Response Lifecycle
- Apply the NIST Incident Response framework in a practical scenario
- Configure open-source incident response tools on Linux
- Establish system baselines for monitoring
- Detect suspicious activity using system and network analysis
- Implement containment strategies
- Preserve forensic evidence
- Perform system recovery and validation
- Document incident response activities professionally

---

## 📚 Prerequisites

- Basic Linux command-line knowledge
- Familiarity with file system navigation
- Understanding of system processes and logs
- Basic networking knowledge (IP, ports, protocols)
- Basic cybersecurity concepts

---

# 🛠 Lab Tasks Overview

---

## 🔎 Task 1 – Tool Configuration & Environment Setup

- Updated system packages
- Installed incident response tools (AIDE, tcpdump, fail2ban, rkhunter, etc.)
- Created structured incident response directory framework
- Developed monitoring and log collection scripts

---

## 🚨 Task 2 – Detection Phase

- Established system baseline (CPU, memory, services, network)
- Initialized AIDE integrity database
- Simulated suspicious activity
- Identified Indicators of Compromise (IOCs)
- Documented detection findings
- Created timeline of events

---

## 🛑 Task 3 – Containment Phase

- Terminated malicious processes
- Quarantined suspicious files
- Preserved volatile evidence
- Documented containment procedures
- Generated containment report

---

## 🔄 Task 4 – Recovery Phase

- Verified system cleanup
- Validated integrity baseline
- Implemented system hardening measures
- Enabled continuous monitoring
- Generated recovery report
- Performed final validation checks

---

# 📁 Folder Structure

```
incident_response/
├── logs/
│   ├── system/
│   ├── network/
│   └── application/
├── evidence/
│   ├── volatile/
│   ├── non-volatile/
│   ├── timeline/
│   └── quarantine/
├── reports/
│   ├── initial/
│   ├── detailed/
│   └── final/
├── scripts/
└── tools/
```

---

# 📊 Incident Response Phases Covered

✔ Detection  
✔ Containment  
✔ Recovery  
✔ Documentation  
✔ Validation  

---

# 🏁 Final Status

- System Operational
- Suspicious Processes Eliminated
- Files Quarantined
- Evidence Preserved
- Integrity Database Updated
- Continuous Monitoring Configured

---

## 📌 Framework Applied

This lab follows principles aligned with:

- NIST Incident Response Lifecycle
- Digital Evidence Preservation Best Practices
- Linux System Hardening Standards

---

## 🏆 Lab Outcome

A complete end-to-end incident response cycle was executed in a controlled environment, demonstrating practical blue team capabilities including detection, containment, forensic preservation, recovery, and reporting.

---
