# 🕵️ Lab 08 – Web Reconnaissance with Maltego

> Environment: Ubuntu 24.04.1 LTS (Cloud EC2)  
> User: toor  
> Instance: toor@ip-172-31-10-207  

---

# 📌 Lab Overview

This lab demonstrates comprehensive web reconnaissance using **Maltego Community Edition** integrated with multiple OSINT tools including:

- theHarvester
- Sublist3r
- Recon-ng
- DNSrecon
- Shodan CLI

The objective was to build a fully integrated OSINT environment capable of visual intelligence analysis, automation, and structured reporting.

---

# 🎯 Objectives

By completing this lab, I successfully:

- Installed and configured Maltego CE on Linux
- Integrated external OSINT tools
- Performed domain and infrastructure reconnaissance
- Created visual intelligence graphs
- Built automation scripts
- Developed custom transforms
- Generated structured reports
- Verified full toolchain integration
- Conducted performance testing

---

# 📚 Prerequisites

- Basic understanding of networking concepts (domains, IP addresses, DNS)
- Familiarity with Linux command line operations
- Knowledge of OSINT (Open Source Intelligence) fundamentals
- Understanding of cybersecurity reconnaissance concepts
- Basic knowledge of email systems and web infrastructure


---

# 🖥 Lab Environment

| Component | Details |
|------------|----------|
| OS | Ubuntu 24.04.1 LTS |
| Java | OpenJDK 21 |
| Maltego Version | 4.5.0 CE |
| User | toor |
| Platform | AWS EC2 Cloud Instance |

---

# 🗂 Repository Structure

```
lab08-web-recon-maltego/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
├── scripts/
│   ├── recon_automation.py
│   ├── email_analysis.py
│   ├── network_analysis.py
│   ├── custom_subdomain_transform.py
│   ├── maltego_report_generator.py
│   ├── verify_integration.py
│   └── performance_test.py
│
├── reports/
│   ├── reconnaissance_report.html
│   └── maltego_export.csv
│
└── evidence/
    ├── harvester_results.txt
    ├── subdomains.txt
    ├── dns_recon_results.txt
    ├── a_records.txt
    ├── mx_records.txt
    └── ns_records.txt
```

---

# ⚙️ Technical Workflow

## 1️⃣ Installation & Setup
- Installed Java (OpenJDK 21)
- Installed Maltego CE
- Installed supporting OSINT tools
- Verified toolchain functionality

## 2️⃣ Domain Reconnaissance
- Created Maltego graph
- Discovered subdomains
- Resolved IP addresses
- Identified hosting provider
- Mapped geolocation

## 3️⃣ Email Intelligence
- Extracted email addresses via theHarvester
- Mapped to persons
- Linked to organization entities

## 4️⃣ External Tool Integration
- Sublist3r for enumeration
- DNSrecon for DNS mapping
- Recon-ng automation
- Shodan CLI verification

## 5️⃣ Custom Transform Development
- Built Sublist3r → Maltego XML transform
- Integrated custom output format

## 6️⃣ Reporting & Automation
- Generated HTML report
- Exported CSV data
- Verified integration
- Performed performance testing

---

# 🔍 Key Findings (Simulated Target: example-target.com)

- 5+ subdomains discovered
- Multiple IP addresses resolved
- Hosting provider identified
- Netblock mapped
- Email addresses linked to domain
- Social intelligence connections created
- Infrastructure geolocation identified

---

# 🛡 Security Relevance

This lab replicates real-world reconnaissance techniques used in:

- Incident Response investigations
- Threat Intelligence operations
- Attack surface mapping
- Red Team reconnaissance
- Infrastructure attribution
- Adversary emulation workflows

Maltego provides visual intelligence analysis which significantly enhances investigative clarity.

---

# 🌍 Real-World Applications

✔ Digital footprint mapping  
✔ Infrastructure attribution  
✔ Threat actor tracking  
✔ Phishing campaign investigation  
✔ Exposure assessment  
✔ External asset discovery  
✔ SOC intelligence workflows  

---

# 📊 Skills Developed

- Advanced OSINT reconnaissance
- Visual intelligence graphing
- Transform chaining
- Toolchain integration
- Python automation scripting
- XML transform generation
- Infrastructure mapping
- Professional reporting

---

# 🧠 What I Learned

- How reconnaissance scales with automation
- How to correlate domains, IPs, emails visually
- How to extend Maltego using custom transforms
- How to validate and test integrated OSINT pipelines
- How adversaries build target intelligence before exploitation
- How to convert reconnaissance into structured IR documentation

---

# 🏁 Conclusion

This lab successfully demonstrated a full-spectrum OSINT reconnaissance workflow using Maltego integrated with external tools.

I built:

- A complete reconnaissance environment
- Automated intelligence collection scripts
- Custom transform extensions
- Structured HTML reporting
- Performance validation scripts

This lab directly strengthens skills required in:

- Incident Response
- Threat Hunting
- Red Teaming
- Digital Forensics
- Infrastructure Analysis
- SOC Operations

---

> All reconnaissance activities were conducted in a controlled lab environment using safe example domains for educational purposes.

---

End of README – Lab 08
