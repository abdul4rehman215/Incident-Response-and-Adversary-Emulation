# 🛡 Lab 10: SMB Scanning with Enum4Linux

---

## 🎯 Objectives

By completing this lab, I was able to:

- Understand SMB (Server Message Block) enumeration fundamentals
- Deploy and configure a local Samba service
- Perform enumeration using Enum4Linux
- Extract users, groups, shares, OS info, and password policies
- Implement RID cycling
- Automate SMB enumeration with Bash scripting
- Develop multi-threaded Python SMB scanners
- Perform risk-based analysis of enumeration results
- Generate structured JSON and summary reports
- Apply SMB enumeration in incident response and adversary emulation

---

# 📚 Prerequisites

- Basic understanding of Linux command-line operations
- Fundamental knowledge of networking concepts (IP addresses, ports, protocols)
- Basic familiarity with Python programming
- Understanding of SMB/CIFS protocol basics
- Knowledge of penetration testing methodologies


---

## 🖥 Lab Environment

- OS: Ubuntu 24.04.1 LTS
- Host: toor@ip-172-31-10-241
- Interface: ens5
- Tools Used:
  - enum4linux
  - samba
  - Python 3
  - Bash scripting

All activities were performed in a controlled lab environment using a locally configured Samba server.

---

# ⚙ Task 1: SMB Enumeration with Enum4Linux

---

## 🔹 1. Verified Enum4Linux Installation

Confirmed installation and reviewed available options:

- `-U` → Users
- `-G` → Groups
- `-S` → Shares
- `-P` → Password Policy
- `-r` → RID Cycling
- `-o` → OS Information
- `-a` → All Enumeration

---

## 🔹 2. Configured Local Samba Service

To ensure safe testing:

- Installed Samba
- Created `/srv/samba/testshare`
- Created users:
  - testuser1
  - testuser2
- Added users to Samba authentication
- Configured `/etc/samba/smb.conf`
- Restarted `smbd` service
- Verified service running

This allowed safe SMB enumeration against localhost.

---

## 🔹 3. Performed Basic SMB Enumeration

Executed:

```
enum4linux -a 127.0.0.1
```

Extracted:

- OS: Unix (Samba 4.19.5)
- Workgroup: WORKGROUP
- Shares:
  - testshare
  - IPC$
- Users:
  - testuser1
  - testuser2
- Groups
- Password policy details

---

## 🔹 4. Targeted Enumeration

Performed focused enumeration:

- Users → `enum4linux -U`
- Groups → `enum4linux -G`
- Shares → `enum4linux -S`
- RID Cycling → `enum4linux -r`
- Password Policy → `enum4linux -P`
- OS Info → `enum4linux -o`

---

# 🛠 Automation Development

---

## 🔹 Bash Automation

Created:

- `SMB_enum_comprehensive.sh`

Automates:
- Full enumeration
- Users
- Groups
- Shares
- Password policy
- OS information
- Structured output directory

---

## 🔹 Python Analysis Script

Created:

- `analyze_smb_results.py`

Capabilities:
- Extract users via regex
- Extract shares
- Generate structured summary
- Provide security recommendations

---

# 🐍 Advanced Python Automation

---

## 🔹 Multi-Threaded SMB Scanner

Created:

- `smb_network_scanner.py`

Features:
- Scans single IP / CIDR / file list
- Checks port 445 before enumeration
- Multi-threaded scanning
- Saves results per target
- Generates scan summary report

---

## 🔹 Advanced SMB Analyzer

Created:

- `advanced_smb_analyzer.py`

Features:
- Extract users
- Extract shares
- Extract OS info
- Perform security risk assessment
- Identify weak usernames
- Detect excessive shares
- Generate:
  - JSON report
  - Human-readable summary

---

# 🔍 Verification Performed

- Verified enum4linux installation
- Verified Samba service running
- Verified users extracted
- Verified scripts executed successfully
- Verified JSON and summary reports generated

---

## 📂 Repository Structure

```
lab10-smb-scanning-enum4linux/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
├── scripts/
│   ├── SMB_enum_comprehensive.sh
│   ├── analyze_smb_results.py
│   ├── smb_network_scanner.py
│   └── advanced_smb_analyzer.py
│
└── smb_enum_results/
    └── (Generated enumeration results)
```

---

---

# 🛡 Security Considerations

SMB enumeration reveals:

- Internal usernames
- Shared resources
- System OS version
- Password policies

In real environments, this data:
- Enables lateral movement
- Supports credential attacks
- Identifies privilege escalation vectors

Therefore:
- Enumeration must only be done with authorization
- SMBv1 should be disabled
- Strong password policies must be enforced
- Share permissions must be strictly controlled

---

# 🎯 Practical Applications

## Incident Response

- Identify exposed SMB services
- Discover rogue user accounts
- Validate password policy configuration
- Assess lateral movement risk

## Adversary Emulation

- Simulate attacker reconnaissance
- Map internal network accounts
- Identify share exposure

## Security Assessment

- Identify weak naming conventions
- Detect excessive shares
- Evaluate SMB attack surface

---

# 💼 Professional Value

This lab demonstrates:

- Real-world SMB enumeration capability
- Bash automation
- Python scripting
- Multi-threaded scanning
- Risk-based reporting
- Structured documentation
- IR & Red Team applicable workflow

These are critical skills for:

- SOC Analysts
- Incident Responders
- Threat Hunters
- Penetration Testers
- Red Team Operators
- Security Engineers

---

# 🏁 Final Conclusion – Lab 10

✔ Samba configured securely  
✔ SMB enumeration performed  
✔ RID cycling implemented  
✔ Bash automation developed  
✔ Multi-target threaded scanner created  
✔ Advanced analyzer with risk assessment built  
✔ JSON and summary reports generated  
✔ Real-world enumeration workflow demonstrated  

This lab strengthens practical adversary emulation and incident response readiness by mastering SMB reconnaissance techniques.

---
