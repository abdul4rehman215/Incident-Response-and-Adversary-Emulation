# 🛡 Lab 07: OSINT with theHarvester  

---

# 🧠 Lab Overview

This lab demonstrates how to perform Open-Source Intelligence (OSINT) gathering using **theHarvester** in a controlled Ubuntu cloud environment. The lab integrates automation, reporting, ethical considerations, and adversary emulation techniques.

TheHarvester is a widely used OSINT reconnaissance tool capable of collecting:

- Email addresses
- Subdomains
- Hosts
- URLs
- Historical DNS data
- Social media intelligence
- Certificate transparency data

This lab bridges **OSINT fundamentals** with **Incident Response and Adversary Emulation workflows**.

---

# 🎯 Objectives

By the end of this lab, I will be able to:

- Understand the fundamentals of Open-Source Intelligence (OSINT) gathering
- Install and configure theHarvester tool on Linux systems
- Use theHarvester to collect email addresses and subdomain information
- Analyze and interpret OSINT data
- Create automated Python scripts
- Apply OSINT in Incident Response (IR) and adversary emulation
- Understand legal & ethical considerations in OSINT activities

---

# 📚 Prerequisites

- Basic understanding of Linux command-line operations
- Fundamental networking knowledge (domains, subdomains, DNS)
- Basic Python programming skills
- Understanding of cybersecurity principles
- Familiarity with nano/vim/gedit
- Linux file system navigation knowledge

---

# 🖥 Lab Environment

- **OS:** Ubuntu 24.04.1 LTS (Cloud – EC2)
- **User:** `toor`
- **Instance:** `toor@ip-172-31-10-184`
- Internet connectivity enabled
- Python 3 and pip installed
- Administrative privileges available

---

# ⚙ Task 1: Installing and Configuring theHarvester

### ✔ System Update
Updated package repositories and ensured system packages were current.

### ✔ Installed Required Dependencies
- python3
- python3-pip
- git
- python3-requests
- python3-beautifulsoup4

### ✔ Cloned theHarvester Repository
Cloned from:
```
https://github.com/laramies/theHarvester.git
```

### ✔ Installed Python Requirements
Installed all dependencies using:
```
pip3 install -r requirements.txt
```

### ✔ Verified Installation
Executed:
```
python3 theHarvester.py -h
```

Confirmed:
- Tool loads correctly
- Engines are listed
- Help menu displays properly

---

# 🔍 Task 2: Basic OSINT Gathering

## 📧 Email Harvesting

Collected email addresses using:

```
-d example.com
-l 100
-b google,bing,yahoo
```

Generated:
- Email lists
- HTML reports
- JSON exports

---

## 🌐 Subdomain Enumeration

Used sources:

- dnsdumpster
- crtsh
- virustotal

Discovered:
- Subdomains
- Associated hosts
- IP mappings

Reports exported to:
- HTML
- JSON

---

## 🔎 Comprehensive Reconnaissance

Executed:

```
-b all
```

Collected:

- Emails
- Subdomains
- Hosts
- URLs

Generated:
- HTML
- JSON
- XML reports

---

# 🚀 Task 3: Advanced Techniques

## 🔑 API Key Configuration

Created configuration:

```
~/.theHarvester/api-keys.yaml
```

Configured for:
- Shodan
- VirusTotal
- Hunter

Enhanced OSINT depth using authenticated APIs.

---

## 🌍 Passive DNS Reconnaissance

Used:
- passivetotal
- crtsh
- certspotter

Collected historical DNS records.

---

## 👥 Social Media Enumeration

Queried:
- LinkedIn
- Twitter

Collected:
- Employee information
- Public social presence
- Organizational footprint

---

# 🤖 Task 4: Python Automation

## 🧾 Script 1 – harvester_automation.py

Automates:
- theHarvester execution
- Report generation
- Timestamped output storage
- HTML report formatting

Generates:
- Structured OSINT reports
- Organized output directory

---

## 📊 Script 2 – advanced_processor.py

Performs:
- Regex extraction
- Email parsing
- Subdomain extraction
- Statistical analysis
- CSV generation
- JSON reporting

Produces:
- Email CSV
- Subdomain CSV
- Comprehensive JSON report

---

## 📈 Script 3 – visualize_results.py

Creates:
- Text-based bar charts
- Domain distribution breakdown
- Top subdomain listing

---

## ⏱ Script 4 – rate_limited_harvest.py

Implements:
- Controlled scanning intervals
- Ethical request throttling
- Delay between search engine queries

Promotes:
- Responsible OSINT
- Avoiding rate-limit bans
- Compliance with service policies

---

# ⚔ Task 5: Practical OSINT Scenarios

## 🛑 Incident Response Simulation

Simulated:
- Recon on potentially compromised domain
- Comprehensive scan
- Structured reporting
- Evidence documentation

Demonstrates:
- Threat intelligence gathering
- Domain investigation
- IR triage support

---

## 🎭 Adversary Emulation Exercise

Simulated red team workflow:

### Phase 1: Initial Recon
- Basic email discovery
- Surface subdomain enumeration

### Phase 2: Deep Enumeration
- Advanced DNS & certificate logs
- Host mapping

### Phase 3: Social Engineering Prep
- Employee intelligence
- Social footprint analysis

---

# 📊 Task 6: Data Analysis & Reporting

## 🧮 Manual Analysis

Used:
- grep
- sort
- uniq
- wc

Extracted:
- Unique emails
- Unique subdomains

---

## 📈 Visualization

Generated:
- Email domain distribution chart
- Subdomain count statistics

---

# ⚖ Task 7: Security & Legal Considerations

Created:
```
osint_legal_checklist.txt
```

Included:

- Authorization requirements
- Domain ownership validation
- GDPR awareness
- Compliance documentation
- Ethical scanning practices

Implemented:
- Rate limiting
- Responsible source usage
- Documentation of actions

---

# ✅ Lab Verification Checklist

✔ theHarvester installed and verified  
✔ Email enumeration completed  
✔ Subdomain discovery completed  
✔ Automation scripts executed  
✔ HTML, JSON, XML reports generated  
✔ CSV reports created  
✔ Incident Response scenario performed  
✔ Adversary emulation simulation completed  
✔ Manual analysis performed  
✔ Visualization generated  
✔ Legal compliance documented  
✔ Rate limiting implemented  

---


## 📂 Repository Structure

```
lab07-osint-with-theharvester/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
├── scripts/
│   ├── harvester_automation.py
│   ├── advanced_processor.py
│   ├── visualize_results.py
│   ├── rate_limited_harvest.py
│   ├── osint_legal_checklist.txt
│
└── reports/
    ├── example.com_*.html
    ├── example.com_*.json
    ├── example.com_*.xml
    ├── emails_example.com_*.csv
    ├── subdomains_example.com_*.csv
    └── comprehensive_report_example.com_*.json
```

---

# 🏁 Conclusion

In this comprehensive OSINT lab:

- theHarvester was successfully deployed in a cloud environment.
- Multi-source reconnaissance was conducted.
- Automation scripts were developed for scalable intelligence gathering.
- Structured reports were generated in HTML, CSV, JSON, and XML formats.
- Incident Response and adversary workflows were simulated.
- Ethical and legal standards were enforced through documentation and rate limiting.

---

# 🌍 Why This Matters (Real-World Relevance)

OSINT is foundational in:

- Incident Response investigations
- Threat Intelligence operations
- Red Team reconnaissance
- Penetration testing
- Digital footprint assessment
- Supply chain security analysis

Security professionals use these techniques to:

- Identify exposed assets
- Detect information leakage
- Map attack surface
- Support breach investigations
- Prepare defensive mitigation strategies

The automation scripts created in this lab demonstrate how OSINT operations can scale while maintaining compliance and ethical standards.

---

# 🎓 Skills Developed

- Linux tool deployment
- OSINT reconnaissance techniques
- Multi-source data correlation
- Python automation
- Structured reporting
- Data extraction & parsing
- Ethical reconnaissance practices
- Incident Response intelligence support

---

⚠ **Reminder:**  
OSINT activities must always be conducted legally, ethically, and with proper authorization. Only collect publicly available information from domains you own or have explicit permission to assess.

---

End of Lab 07 – OSINT with theHarvester
