# 🛡 Lab 18 – C2 Evasion Techniques (Safe Simulation Version)

---

## 📌 Overview

This lab demonstrates Command & Control (C2) evasion techniques in a controlled and safe Linux environment using Python-based simulations.

⚠️ No real malware  
⚠️ No real C2 framework  
⚠️ Everything runs locally for educational purposes only  

The objective is to understand how beaconing traffic attempts to evade detection — and how defenders analyze and detect such activity.

---

## 🎯 Objectives

By the end of this lab, I was able to:

- Build a simulated C2 server using Python
- Develop a beaconing implant simulation
- Implement jitter-based communication
- Rotate User-Agent strings
- Add anti-analysis checks
- Simulate persistence safely
- Analyze network traffic patterns
- Test detection logic
- Simulate domain fronting behavior
- Understand OPSEC considerations

---

## 📚 Prerequisites

- Basic Linux command line knowledge  
- Understanding of TCP/IP and HTTP/HTTPS  
- Familiarity with cybersecurity concepts (C2 frameworks)  
- Experience using nano or vim  
- Basic Python scripting knowledge  

---

## 🖥 Lab Environment

**OS:** Ubuntu 20.04 LTS  
**Environment:** Cloud Lab  
**User:** toor  
**Instance:** ip-172-31-10-219  

Pre-installed components:

- Python 3.8+
- curl
- net-tools
- tcpdump
- pip3

---

# 🧩 Lab Tasks Overview

---

## Task 1 – Environment Preparation

- Updated system packages
- Installed required tools
- Created structured lab directory

---

## Task 2 – Simulated C2 Server

- Built Python-based HTTP server
- Implemented beacon logging
- Returned JSON responses
- Logged client IP and User-Agent

---

## Task 3 – Simulated Beacon Implant

- Developed Python beacon
- Implemented jitter (random sleep intervals)
- Rotated User-Agent headers
- Added anti-analysis checks
- Established periodic C2 communication

---

## Task 4 – Network Traffic Analysis

- Captured beacon traffic using tcpdump
- Observed timing intervals
- Analyzed HTTP headers
- Identified obfuscation attempts

---

## Task 5 – Persistence Simulation

- Modified .bashrc
- Simulated auto-start behavior
- Verified background execution

---

## Task 6 – Domain Fronting Simulation

- Modified HTTP Host header
- Simulated fronted request
- Observed C2 response

---

## Task 7 – Detection Testing

- Built process detection script
- Enumerated listening ports
- Verified beacon activity

---

# 📂 Repository Structure

```

lab18-c2-evasion-simulation/
│
├── README.md
├── commands.sh
├── output.txt
├── interview.md
├── troubleshooting.md
│
└── scripts/
├── c2_server.py
├── beacon.py
├── persistence.sh
├── domain_fronting.sh
├── detection_test.sh
└── c2_server.log

```

---

# 🧠 What I Learned

Through this lab I understood:

- How C2 beaconing works at the protocol level
- How jitter helps evade signature detection
- Why User-Agent rotation attempts to blend malicious traffic
- How anti-analysis logic attempts to avoid debugging
- How domain fronting manipulates HTTP headers
- Why behavioral detection is critical

---

# 🛡 Why This Matters

Modern attackers rely on:

- Encrypted HTTP/HTTPS beaconing
- Randomized timing intervals
- Header obfuscation
- Living-off-the-land techniques
- Persistence mechanisms

Understanding these techniques helps defenders:

- Identify abnormal beacon intervals
- Detect suspicious User-Agent patterns
- Monitor long-lived outbound connections
- Implement anomaly-based detection
- Improve SOC monitoring rules

---

# 🌍 Real-World Relevance

These concepts apply directly to:

- SOC monitoring
- Threat hunting
- Incident response
- Network forensics
- Red team simulations (controlled)
- Detection engineering

Enterprise environments regularly face:

- Beaconing malware
- Command & Control channels
- Stealth persistence
- Traffic obfuscation attempts

---

# 🏁 Result

Successfully implemented:

✔ Simulated C2 infrastructure  
✔ Beacon with jitter & obfuscation  
✔ Anti-analysis checks  
✔ Persistence simulation  
✔ Domain fronting simulation  
✔ Detection validation  
✔ Network traffic inspection  

This lab strengthened both offensive simulation knowledge and defensive analysis capability.

---

# ⚖️ Ethical Reminder

⚠️ These techniques must only be used in authorized lab environments.

The purpose of learning evasion techniques is to build stronger defenses — not bypass them.

Use this knowledge responsibly and legally.
