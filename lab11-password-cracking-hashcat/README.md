# 🛡 Lab 11: Password Cracking with Hashcat  

---

## 📌 Overview

This lab focuses on understanding password cracking methodologies using **Hashcat**, one of the most powerful password recovery tools available. The lab demonstrates practical cracking techniques using:

- Dictionary attacks
- Brute-force attacks
- Rule-based attacks
- Combination attacks
- GPU acceleration
- Performance benchmarking
- Hash-type comparison
- Reporting & validation

All testing was performed in a controlled lab environment on:

**System:** Ubuntu 24.04.1 LTS  
**User:** toor  
**Instance:** ip-172-31-10-252  
**GPU:** NVIDIA Tesla T4  

---

## 🎯 Objectives

By completing this lab, I successfully:

- Installed and configured Hashcat
- Verified OpenCL and GPU acceleration
- Generated MD5 and SHA-256 hash files
- Performed dictionary attacks
- Implemented brute-force attacks
- Used rule-based mutations
- Executed combination attacks
- Benchmarked CPU vs GPU performance
- Compared hash algorithm resistance
- Generated structured cracking reports

---

# 📚 Prerequisites

- Basic understanding of Linux command-line operations
- Fundamental knowledge of cryptographic hash functions (MD5, SHA-1, SHA-256)
- Basic understanding of password security concepts
- Familiarity with file system navigation and text editing in Linux
- Understanding of cybersecurity ethics and legal considerations

---

## 🧠 Why This Matters (Real-World Relevance)

Password cracking is critical in:

### 🔍 Incident Response
- Analyzing breached credential dumps
- Assessing compromised accounts
- Measuring password policy strength

### 🔴 Red Team Operations
- Simulating adversary password attacks
- Evaluating weak password exposure
- Testing hash storage resilience

### 🧾 Digital Forensics
- Recovering credentials from seized systems
- Analyzing hashed databases

### 🛡 Security Assessment
- Auditing password policies
- Testing hash algorithm strength
- Demonstrating GPU cracking feasibility

---

## 🔥 Key Technical Insights

| Hash Type | GPU Speed (Tesla T4) | Security Strength |
|------------|----------------------|------------------|
| MD5        | ~28 GH/s             | ❌ Extremely Weak |
| NTLM       | ~32 GH/s             | ❌ Extremely Weak |
| SHA-256    | ~950 MH/s            | ⚠ Moderate |
| bcrypt     | ~950 H/s             | ✅ Strong |

🚨 Critical Insight:
Fast hash algorithms = extremely vulnerable to GPU cracking.

---

## 📂 Repository Structure
```
lab11-password-cracking-hashcat/
│
├── README.md
├── commands.sh
├── output.txt
├── interview_qna.md
├── troubleshooting.md
│
├── hashes/
│ ├── md5_hashes.txt
│ ├── sha256_hashes.txt
│ ├── simple_md5.txt
│ └── combo_test.txt
│
├── cracked/
│ ├── md5_cracked.txt
│ ├── sha256_cracked.txt
│ ├── md5_simple_cracked.txt
│ ├── md5_combo_test_cracked.txt
│ └── top1m_cracked.txt
│
├── wordlists/
│ ├── custom_wordlist.txt
│ ├── left.txt
│ └── right.txt
│
├── reports/ 
│ ├── benchmark_results.txt
│ ├── metric_report.txt
│ └── final_report.txt
│
├── scripts/
│ ├── performance_test.sh
│ ├── benchmark.sh
│ ├── optimized_crack.sh
│ ├── analysis_report.sh
│ ├── metrics.sh
│ └── validate_lab.sh
```


---

## 🧪 Attack Techniques Implemented

### 1️⃣ Dictionary Attack
Used custom wordlists to instantly crack weak passwords.

### 2️⃣ Brute Force Attack
Used mask attack mode (`-a 3`) with:
- Lowercase masks (?l?l?l)
- Numeric masks (?d?d?d)

### 3️⃣ Rule-Based Attack
Applied custom mutation rules to expand dictionary effectiveness.

### 4️⃣ Combination Attack
Combined left + right wordlists to generate hybrid passwords.

### 5️⃣ GPU Acceleration
Measured performance difference between CPU and GPU devices.

---

## 📊 Performance Comparison (CPU vs GPU)

| Mode | Time |
|------|------|
| CPU Only | ~2.48s |
| GPU | ~0.21s |

🚀 GPU was ~10x faster in this controlled test.

---

## 🛡 Security Lessons Learned

- Weak passwords are cracked instantly.
- Unsalted MD5 is practically broken.
- SHA-256 is stronger but still vulnerable to GPU attacks.
- bcrypt drastically increases cracking time.
- Rule-based attacks dramatically improve success rate.
- Salting + adaptive hashing is essential.

---

## 💼 Professional Value

This lab demonstrates:

- Practical password audit capability
- GPU performance benchmarking
- Attack mode selection expertise
- Hash type identification
- Structured reporting skills
- Realistic adversary simulation

Relevant Roles:

- SOC Analyst
- Incident Responder
- Threat Hunter
- Penetration Tester
- Red Team Operator
- Security Engineer

---

## 🏁 Final Status

✔ Hashcat installed & verified  
✔ GPU acceleration confirmed  
✔ Dictionary attacks successful  
✔ Brute-force attacks successful  
✔ Rule-based attacks applied  
✔ Combination attacks executed  
✔ Benchmark completed  
✔ Performance metrics collected  
✔ Report generated  
✔ Lab validated  

---

## ⚠ Ethical Reminder

All password cracking techniques demonstrated in this lab were performed in a **controlled and authorized environment**.

Always follow:
- Legal compliance
- Written authorization
- Responsible disclosure
- Ethical cybersecurity practices

---

# 🚀 Lab 11 Completed Successfully

