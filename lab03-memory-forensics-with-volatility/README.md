# 🧠 LAB 03 — Memory Forensics with Volatility

## 🧭 Overview

This lab demonstrates practical memory forensics techniques using the Volatility Framework and LiME (Linux Memory Extractor). The exercise simulates suspicious activity within a live Linux system, followed by full memory acquisition and forensic analysis.

The lab follows a structured incident-response methodology:
1. Environment preparation
2. Memory acquisition
3. Artifact analysis
4. Rootkit detection
5. Malware signature scanning
6. Forensic report generation

---

## 🎯 Objectives

By completing this lab, I was able to:

- Understand fundamentals of memory forensics
- Install and configure Volatility 2 and Volatility 3
- Acquire live memory using LiME
- Analyze running processes and network artifacts
- Detect suspicious scripts and file access in memory
- Perform rootkit detection checks
- Conduct signature-based malware analysis
- Generate structured forensic reports
- Archive complete forensic evidence

---

## 🖥 Lab Environment

- **Operating System:** Ubuntu 24.04.1 LTS
- **Hostname:** ip-172-31-10-251
- **User:** toor
- **Privileges:** sudo enabled
- **Internet Access:** Enabled

---

## 📌 Prerequisites

- Basic understanding of Linux command line operations
- Fundamental knowledge of operating system processes and memory management
- Basic familiarity with cybersecurity concepts
- Understanding of malware and rootkit concepts
- No prior experience with Volatility is required as this lab covers installation and basic usage

---

## 🔬 Key Activities Performed

### 1️⃣ Tool Installation
- Installed Volatility 2 & 3
- Compiled and configured LiME
- Verified environment dependencies

### 2️⃣ Memory Acquisition
- Created live memory dump (~3.9GB)
- Verified dump integrity
- Removed acquisition module safely

### 3️⃣ Process Analysis
- Identified suspicious Python process
- Mapped parent-child relationships
- Correlated shell activity

### 4️⃣ Network Analysis
- Identified listeners on:
  - Port 8080 (HTTP)
  - Port 9999 (Netcat)
- Detected loopback communication activity

### 5️⃣ Artifact Extraction
- Dumped suspicious process memory
- Extracted ELF binaries
- Identified sensitive file access (`/etc/passwd`)

### 6️⃣ Rootkit Detection
- Compared pslist vs pstree
- Analyzed kernel modules
- Checked hidden/deleted file handles
- No rootkit behavior confirmed

### 7️⃣ Malware Signature Scan
- Searched memory for:
  - meterpreter
  - metasploit
  - shellcode
  - rootkit
  - ransomware
- No known malware signatures detected

---

## 🔍 Key Findings

| Category | Result |
|----------|--------|
| Suspicious Processes | `python3 suspicious_script.py` |
| Network Listeners | 8080 (HTTP), 9999 (Netcat) |
| Sensitive File Access | `/etc/passwd` |
| Hidden Processes | None |
| Kernel Rootkit | Not detected |
| Malware Signatures | Not detected |

---

## 📊 Result

- Full memory dump successfully created.
- Suspicious activity identified and validated.
- No advanced rootkit or hidden process artifacts detected.
- Complete forensic documentation generated.
- Evidence archived for future review.

---

## 🧠 What I Learned

- Memory contains critical live forensic artifacts.
- Rootkits may hide processes and modules in RAM.
- Volatility 3 provides structured, plugin-based memory analysis.
- Comparing process views helps detect hidden processes.
- Memory artifact extraction aids malware investigation.
- Proper documentation is essential in digital forensics.

---

## 🌍 Real-World Relevance

Memory forensics is critical in:

- Incident response investigations
- Advanced Persistent Threat (APT) detection
- Malware reverse engineering
- Insider threat investigations
- Live compromise analysis
- Legal forensic investigations

Many sophisticated attacks leave artifacts only in RAM. Disk-based analysis alone may miss active threats.

---

## 🚀 Why This Matters

Modern malware often:
- Runs filelessly
- Lives only in memory
- Injects into legitimate processes
- Deletes disk traces

Memory forensics allows analysts to:
- Capture live system state
- Identify in-memory artifacts
- Detect rootkits and injected code
- Reconstruct attack timelines

This lab strengthens practical DFIR capabilities.

---

## 📁 Repository Structure

```

LAB-03-Memory-Forensics/
│
├── README.md
├── commands.sh
├── output.txt
├── interview.md
├── troubleshooting.md
│
├── scripts/
│   ├── rootkit_detection.sh
│   ├── advanced_rootkit_detection.sh
│   ├── signature_detection.sh
│   ├── comprehensive_analysis.sh
│   └── generate_final_report.sh
│
└── artifacts/
├── process-list.txt
├── network-connections.txt
├── loaded-modules.txt
├── open-files.txt
├── rootkit-analysis.txt
└── signature-analysis.txt

```

---

## 🏁 Conclusion

This lab provided hands-on experience in:

- Live memory acquisition
- Memory artifact extraction
- Process and network forensics
- Rootkit detection techniques
- Automated forensic reporting

Memory forensics is a core skill in modern cybersecurity investigations. The techniques practiced here are directly applicable to real-world DFIR operations.
