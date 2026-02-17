# 📘 Interview Q&A – Lab 03: Memory Forensics with Volatility

---

### Q1. What is memory forensics and why is it important?

**Answer:**  
Memory forensics is the analysis of volatile memory (RAM) to identify active processes, network connections, injected code, decrypted data, and other live system artifacts. It is important because many advanced threats operate only in memory and may not leave traces on disk.

---

### Q2. What tool was used to acquire live memory in this lab?

**Answer:**  
LiME (Linux Memory Extractor) was used to acquire a full memory dump from the live Ubuntu system.

---

### Q3. What is the difference between Volatility 2 and Volatility 3?

**Answer:**  
Volatility 2 relies on predefined profiles and manual configuration, while Volatility 3 uses dynamic symbol tables and improved plugin architecture for more accurate and flexible analysis.

---

### Q4. How do you identify the operating system profile in Volatility 3?

**Answer:**  
By running:

```bash
vol3 -f memory-dump.lime linux.banner
````

This detects the Linux kernel version and OS information automatically.

---

### Q5. Which Volatility plugin lists running processes?

**Answer:**
The plugin:

```bash
vol3 -f memory-dump.lime linux.pslist
```

is used to list active processes from memory.

---

### Q6. How can suspicious network activity be identified in memory?

**Answer:**
By using:

```bash
vol3 -f memory-dump.lime linux.netstat
```

This reveals listening ports and established connections that may indicate backdoors or unauthorized services.

---

### Q7. What indicated suspicious behavior in this lab?

**Answer:**

* A Python script continuously accessing `/etc/passwd`
* Network listeners on ports 8080 and 9999
* Loopback socket connections created by the suspicious script

---

### Q8. How do you detect hidden processes in memory?

**Answer:**
By comparing outputs of:

```bash
linux.pslist
linux.pstree
```

If process counts differ, it may indicate hidden processes manipulated by a rootkit.

---

### Q9. Which plugin helps detect suspicious kernel modules?

**Answer:**
The plugin:

```bash
vol3 -f memory-dump.lime linux.lsmod
```

lists loaded kernel modules and helps identify unauthorized or malicious modules.

---

### Q10. How were malware signatures searched in memory?

**Answer:**
Using the `strings` command combined with keyword-based scanning for known malware signatures such as:

* meterpreter
* metasploit
* shellcode
* rootkit
* ransomware

---

### Q11. Why is memory analysis valuable in incident response?

**Answer:**
Memory analysis reveals:

* Active malware
* Decrypted credentials
* Live network sessions
* Injected code
* Rootkits hiding from disk-based tools

These artifacts may not be present on disk, making memory forensics critical for modern investigations.

---

### Q12. What are indicators of compromise (IOCs) observed in this lab?

**Answer:**

* Suspicious background Python script execution
* Unauthorized network listeners
* Sensitive file access from memory
* Unexpected local socket activity

---

### Q13. Why is LiME preferred for Linux memory acquisition?

**Answer:**
LiME is a loadable kernel module designed specifically for acquiring Linux memory safely and accurately while preserving forensic integrity.

---

### Q14. What are common real-world use cases of memory forensics?

**Answer:**

* Advanced Persistent Threat (APT) investigations
* Malware analysis
* Insider threat detection
* Rootkit detection
* Live incident response

---

### Q15. What is the key takeaway from this lab?

**Answer:**
Memory contains critical forensic artifacts that cannot always be recovered from disk. Proper acquisition, systematic analysis, and structured reporting are essential skills for cybersecurity and DFIR professionals.

