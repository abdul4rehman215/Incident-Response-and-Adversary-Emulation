# 🛡 Lab 17 – Lateral Movement and Pivoting (Safe Simulation Version)

---

## 📌 Overview

This lab demonstrates lateral movement, pivoting, simulated C2 infrastructure, and persistence techniques using safe Python and Linux tools in a controlled environment.

⚠️ No real malware.  
⚠️ No real C2 framework.  
⚠️ Everything runs locally for educational purposes only.

The goal is to understand how attackers move inside networks — and how defenders detect and respond.

---

## 🎯 Objectives

By the end of this lab, students will be able to:

- Build a simulated C2 server
- Develop a beaconing agent
- Simulate lateral movement using SSH
- Simulate pivoting via port forwarding
- Map network topology
- Identify pivot points
- Simulate persistence mechanisms safely
- Analyze C2-like traffic
- Implement basic obfuscation techniques
- Understand OPSEC considerations

---

## 📚 Prerequisites

- Basic Linux command line knowledge  
- Fundamental networking knowledge (TCP/IP, HTTP/HTTPS)  
- Basic cybersecurity concepts (C2, lateral movement)  
- Familiarity with nano/vim  
- Understanding of Linux processes  
- Basic scripting knowledge (Bash/Python)

---

## 🖥 Lab Environment

**OS:** Ubuntu 24.04.1 LTS  
**Environment:** Cloud Lab  
**User:** toor  
**Instance:** ip-172-31-10-219  

Pre-installed components:

- Python3
- OpenSSH Server
- net-tools
- tcpdump
- curl

---

# 🧩 Lab Tasks Overview

---

## Task 1 – Environment Preparation

- Update system
- Install required tools
- Configure SSH service
- Create lab directory structure

---

## Task 2 – Build Simulated C2 Infrastructure

- Develop Python-based C2 server
- Log beacon activity
- Respond with structured JSON

---

## Task 3 – Create Simulated Beacon Agent

- Develop Python beacon agent
- Implement jitter
- Rotate User-Agent
- Add anti-analysis logic
- Send periodic beacons to C2

---

## Task 4 – Simulate Lateral Movement

- Create secondary user
- SSH into pivot account
- Simulate host-to-host movement

---

## Task 5 – Simulate Pivoting

- Use SSH port forwarding
- Forward port 9090 → 8080
- Access C2 via pivot channel

---

## Task 6 – Network Mapping

- Identify interfaces
- Enumerate open ports
- Identify pivot points (SSH & C2)

---

## Task 7 – Traffic Analysis

- Capture C2 traffic with tcpdump
- Observe beacon behavior
- Analyze User-Agent rotation

---

## Task 8 – Simulate Persistence

- Add beacon execution to .bashrc
- Simulate automatic execution

---

## Task 9 – Detection Engineering

- Develop detection script
- Identify beacon process
- Detect listening ports
- Identify SSH sessions

---

# 📂 Repository Structure

```

lab17-lateral-movement-simulation/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
└── scripts/
├── simulated_c2.py
├── beacon_agent.py
├── persistence_sim.sh
├── detection_test.sh
└── c2_activity.log

```

---

# 🔐 Security Relevance

This lab demonstrates core adversary behaviors:

- Command & Control (C2) communication
- East-west movement
- SSH pivoting
- Port forwarding abuse
- Traffic obfuscation
- Persistence mechanisms

Understanding these techniques helps defenders:

- Detect abnormal internal traffic
- Identify unauthorized pivot points
- Monitor suspicious processes
- Improve detection engineering
- Harden internal network architecture

---

# 🏁 Conclusion

This safe simulation demonstrated:

- Building C2 infrastructure
- Beacon communication logic
- Lateral movement via SSH
- Pivoting via port forwarding
- Traffic capture and analysis
- Persistence techniques
- Detection engineering principles

This lab bridges offensive simulation with defensive analysis.

---

# ⚖️ Ethical Reminder

⚠️ These techniques must only be used in authorized environments.

Unauthorized C2 deployment or lateral movement attempts are illegal and unethical.

The goal of this lab is stronger defense — not exploitation.

---

# 📌 Result

A complete simulated lateral movement and pivoting workflow was successfully implemented and analyzed in a controlled Linux environment.
