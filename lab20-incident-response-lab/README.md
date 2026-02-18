# 🛡 Lab 20: Final Incident Response Simulation

---

## 📌 Overview

This lab simulates a complete Security Operations Center (SOC) environment using open-source security tools.  
It walks through the full incident response lifecycle — from detection to final documentation — using a single Ubuntu cloud machine.

Students deploy and integrate:

- Wazuh (SIEM + EDR)
- Suricata (IDS/IPS)
- Zeek (Network Security Monitoring)

Then simulate multi-vector attacks and execute structured incident response procedures following industry best practices (NIST IR framework).

This lab mirrors real-world SOC operations.

---

## 🎯 Objectives

By the end of this lab, students will be able to:

- Deploy a full SOC monitoring stack
- Configure Wazuh for centralized log analysis
- Deploy Suricata for intrusion detection
- Deploy Zeek for deep network visibility
- Integrate logs across tools
- Simulate realistic cyber attacks
- Detect and analyze security events
- Execute structured incident response playbooks
- Perform containment, eradication, and recovery
- Preserve forensic evidence
- Generate executive and technical reports

---

## 📚 Prerequisites

Students should have:

- Basic Linux command-line knowledge
- Understanding of TCP/IP networking
- Familiarity with log analysis
- Knowledge of common attack techniques
- Understanding of incident response lifecycle phases

---

## 🖥 Lab Environment

| Component | Details |
|-----------|----------|
| OS | Ubuntu 24.04.1 LTS |
| User | toor |
| Instance | ip-172-31-10-219 |
| RAM | 8GB |
| Storage | 50GB |
| Deployment | Single-machine SOC |

All tools run locally on one system.

---

## 🏗 Repository Structure

```
lab20-incident-response-lab/
│
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
├── logs/
│
├── scripts/
│   ├── port_scan_simulation.sh
│   ├── web_attack_simulation.sh
│   ├── malware_simulation.sh
│   ├── incident_response_playbook.sh
│   ├── containment_procedures.sh
│   ├── eradication_recovery.sh
│   ├── post_incident_analysis.sh
│   ├── security_verification.sh
│   └── compile_documentation.sh
│
├── evidence/
│
├── reports/
│   ├── detection_summary.txt
│   ├── incident_timeline.txt
│   ├── lessons_learned.txt
│   ├── executive_summary.txt
│   └── security_status.txt
│
└── final_documentation/
    ├── master_incident_report.txt
    ├── manifest.txt
    ├── evidence_archive.tar.gz
    └── configurations/
```

---

## 🔍 Lab Phases

1. Environment Preparation  
2. SOC Stack Deployment  
3. Attack Simulation  
4. Detection & Correlation  
5. Incident Classification  
6. Evidence Collection  
7. Containment  
8. Eradication  
9. Recovery  
10. Post-Incident Analysis  
11. Documentation Compilation  

---

## 🧠 What I Learned

- Multi-tool log correlation
- IDS/IPS tuning concepts
- SIEM alert analysis
- Evidence preservation
- Firewall containment procedures
- Malware cleanup simulation
- Service recovery validation
- Incident documentation lifecycle
- Executive-level reporting

---

## 🌍 Why This Matters (Real-World Relevance)

Modern organizations handle hundreds of alerts daily.

This lab simulates:

- SOC Analyst daily workflow
- Blue Team detection engineering
- NIST incident response lifecycle
- Chain-of-custody evidence handling
- Executive security reporting

The tools used (Wazuh, Suricata, Zeek) are widely deployed in enterprise environments.

Hands-on experience with these tools directly maps to real SOC operations.

---

## 📊 Result

✔ SOC stack deployed  
✔ Multi-vector attack detected  
✔ Alerts correlated  
✔ Evidence preserved  
✔ Containment executed  
✔ Systems hardened  
✔ Services restored  
✔ Documentation archived  

Full incident lifecycle completed successfully.

---

## 🔐 Security Notice

This lab is for educational use only.

All attack simulations are controlled and local.  
Do not deploy IDS/IPS or containment rules in production environments without authorization.

---
