# 🛡 Lab 16 – Privilege Escalation with Mimikatz (Simulated Environment)

---

## 📌 Overview

This lab simulates Windows credential extraction and privilege escalation techniques using Mimikatz in a controlled Linux + Wine environment.

The objective is to understand how Windows credentials are stored, how attackers extract them, and how defenders can detect and mitigate credential theft techniques.

⚠️ This lab is performed in a simulated environment strictly for educational and defensive security training purposes.

---

## 🎯 Objectives

By the end of this lab, students will be able to:

- Understand Windows credential storage mechanisms
- Simulate credential extraction using Mimikatz via Wine
- Automate privilege escalation checks using PowerShell
- Analyze insecure configurations enabling credential theft
- Implement defensive hardening measures
- Monitor credential access attempts

---

## 📚 Prerequisites

- Basic Windows operating system knowledge  
- Familiarity with PowerShell scripting  
- Understanding of NTLM and Kerberos authentication  
- Basic Python programming skills  
- Knowledge of ethical hacking principles  

---

## 🖥 Lab Environment

**Operating System:** Ubuntu 24.04.1 LTS  
**Environment:** Cloud-based EC2 Lab  
**User:** toor  
**Instance:** ip-172-31-10-203  

Installed Components:

- Wine 8.0
- PowerShell 7.4.1
- Python 3.12.3
- winetricks
- Mimikatz (x64 version)

---

## 🧪 Environment Verification

System verified using:

```

cat /etc/os-release
wine --version
pwsh --version
python3 --version

```

All required tools were present and functional.

---

# 🧩 Lab Tasks Overview

---

## Task 1 – Environment Preparation

- Verify Wine, PowerShell, and Python installations
- Configure Wine for Windows 10 compatibility
- Install required dependencies (vcrun2019, dotnet48)
- Create simulated LSASS credential dump using Python

---

## Task 2 – Credential Extraction

- Explore Mimikatz modules
- Simulate credential extraction using sekurlsa::logonpasswords
- Extract NTLM hashes using lsadump::sam
- Parse and generate structured extraction reports
- Perform password security analysis

---

## Task 3 – Privilege Escalation Assessment

- Create PowerShell enumeration script
- Check administrative privileges
- Assess LSA Protection status
- Detect WDigest configuration
- Identify privilege escalation vectors
- Export automated assessment report

---

## Task 4 – Defensive Hardening

- Disable WDigest
- Enable LSA Protection
- Configure audit policies
- Provide Credential Guard & LAPS recommendations
- Generate hardening report
- Implement credential access monitoring
- Detect Mimikatz execution indicators

---

# 📂 Repository Structure

```

lab16-privilege-escalation-mimikatz/
│
├── README.md
├── commands.sh
├── output.txt
├── interview.md
├── troubleshooting.md
│
└── scripts/
├── simulate_credentials.py
├── extract_credentials.py
├── analyze_passwords.py
├── privilege_check.ps1
├── implement_defenses.py
├── monitor_credential_access.py
├── simulated_lsass.dmp
├── credentials.json
├── extraction_report.json
├── password_security_report.json
├── assessment_results.json
└── hardening_report.json

```

---

# 🔐 Security Relevance

Credential theft remains one of the most critical post-exploitation techniques used by attackers.

Tools like Mimikatz target:

- LSASS memory
- NTLM hashes
- Kerberos tickets
- Plaintext credentials (via WDigest)

Understanding both offensive techniques and defensive countermeasures is essential for:

- SOC Analysts
- Incident Responders
- Red Teamers
- Blue Team Engineers
- Windows Security Administrators

---

# 🏁 Conclusion

This lab demonstrated:

- How Windows credentials are stored in LSASS memory
- How Mimikatz extracts plaintext passwords and NTLM hashes
- How insecure configurations increase privilege escalation risk
- How automation improves defensive posture
- How monitoring detects credential theft attempts

A complete offensive-to-defensive workflow was simulated in a controlled environment.

---

# ⚖️ Ethical Reminder

⚠️ These techniques must only be used in authorized penetration testing engagements or controlled lab environments. Unauthorized credential harvesting is illegal and unethical.

---

# 📌 Result

A full credential extraction simulation, privilege assessment automation, and defensive hardening workflow was successfully implemented and validated.
