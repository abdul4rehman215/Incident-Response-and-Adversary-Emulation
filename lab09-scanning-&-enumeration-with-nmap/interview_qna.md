# 🎤 Interview QNA - Lab 09: Scanning & Enumeration with Nmap

---

## 🔹 SECTION 1: Nmap Fundamentals

---

### 1️⃣ What is Nmap and why is it important in cybersecurity?

**Answer:**

Nmap (Network Mapper) is an open-source network scanning and enumeration tool used to discover hosts, services, operating systems, and vulnerabilities on a network.

It is critical in cybersecurity because it:

* Identifies open ports and exposed services
* Maps network attack surface
* Detects unauthorized services
* Assists in vulnerability discovery
* Supports incident response investigations
* Enables adversary emulation and red-team reconnaissance

It is widely used by:

* SOC Analysts
* Incident Responders
* Penetration Testers
* Red Teams
* Security Engineers

---

### 2️⃣ What is the difference between host discovery and port scanning?

**Answer:**

**Host Discovery**
Determines whether a system is alive and reachable.
Example:

```
nmap -sn 192.168.1.0/24
```

**Port Scanning**
Identifies open ports and services on a host.
Example:

```
nmap 192.168.1.10
```

Host discovery answers:

> “Is the system online?”

Port scanning answers:

> “What services are exposed?”

---

### 3️⃣ What is a SYN scan and why is it called a stealth scan?

**Answer:**

SYN scan (`-sS`) sends a TCP SYN packet but does not complete the handshake.

Process:

1. Sends SYN
2. If SYN-ACK received → port is open
3. Sends RST instead of completing handshake

Example:

```
sudo nmap -sS 127.0.0.1
```

It is called stealth because:

* It does not fully establish TCP connections
* It is harder to log compared to full connect scans

---

### 4️⃣ Difference between TCP Connect scan and SYN scan?

| Feature             | TCP Connect (-sT) | SYN Scan (-sS) |
| ------------------- | ----------------- | -------------- |
| Requires root       | ❌ No              | ✅ Yes          |
| Completes handshake | ✅ Yes             | ❌ No           |
| Stealthier          | ❌ No              | ✅ Yes          |
| Faster              | Moderate          | Faster         |

---

### 5️⃣ What does -p- do in Nmap?

**Answer:**

`-p-` scans all 65535 TCP ports.

Example:

```
nmap -p- 127.0.0.1
```

Used when:

* Full attack surface discovery is required
* Incident response investigations demand complete visibility

---

## 🔹 SECTION 2: Advanced Scanning

---

### 6️⃣ What does the -A option do?

**Answer:**

`-A` performs aggressive scanning including:

* OS detection
* Version detection
* Script scanning
* Traceroute

Example:

```
nmap -A 127.0.0.1
```

It is comprehensive but:

* Noisy
* Detectable
* Slower

---

### 7️⃣ How does service version detection work?

**Answer:**

Using:

```
nmap -sV 127.0.0.1
```

Nmap:

* Sends probes to services
* Matches responses against service fingerprint database
* Identifies versions

Example result:

```
OpenSSH 9.6p1
Apache 2.4.58
```

This is crucial for:

* Vulnerability research
* Patch management
* Threat analysis

---

### 8️⃣ What is OS fingerprinting?

**Answer:**

OS detection (`-O`) analyzes:

* TCP window size
* TTL values
* Response patterns
* TCP options

Example:

```
sudo nmap -O 127.0.0.1
```

Output:

```
Linux 5.x
```

Used in:

* Adversary emulation
* Attack simulation
* Asset profiling

---

## 🔹 SECTION 3: Nmap Scripting Engine (NSE)

---

### 9️⃣ What is NSE?

**Answer:**

NSE (Nmap Scripting Engine) allows execution of scripts for:

* Enumeration
* Vulnerability detection
* Brute force attacks
* Malware detection

Scripts located in:

```
/usr/share/nmap/scripts/
```

---

### 🔟 How do you run default scripts?

```
nmap -sC 127.0.0.1
```

---

### 1️⃣1️⃣ How do you run vulnerability scripts?

```
nmap --script vuln 127.0.0.1
```

These check for:

* Known CVEs
* Misconfigurations
* Weak services

---

### 1️⃣2️⃣ What is http-enum script used for?

```
nmap --script http-enum 127.0.0.1
```

It performs:

* Directory enumeration
* Common file discovery
* Web misconfiguration detection

---

## 🔹 SECTION 4: Automation & Scripting

---

### 1️⃣3️⃣ Why automate Nmap scanning?

**Answer:**

Automation provides:

* Repeatability
* Speed
* Structured output
* Consistency
* Scalability

In this lab:

* Created automated scanner
* Built multi-target framework
* Generated structured reports
* Developed analysis script

This demonstrates:

> DevSecOps skillset

---

### 1️⃣4️⃣ Why use Bash for automation?

Because Bash:

* Is native to Linux
* Handles file operations easily
* Integrates with security tools
* Suitable for automation pipelines

---

### 1️⃣5️⃣ How can Nmap be integrated into CI/CD?

* Automated nightly scans
* Scan before deployment
* Alert on new open ports
* Integrate with SIEM

Example:

```
cron job → nmap scan → store output → analyze → alert
```

---

## 🔹 SECTION 5: Incident Response Perspective

---

### 1️⃣6️⃣ How is Nmap used during Incident Response?

Used to:

* Identify exposed services
* Detect unauthorized listening ports
* Compare baseline vs compromised host
* Validate attacker persistence mechanisms

Example:
Unexpected open port 4444 → Possible backdoor.

---

### 1️⃣7️⃣ How can attackers misuse Nmap?

Attackers use Nmap for:

* Reconnaissance
* Service discovery
* OS detection
* Identifying weak services
* Target selection

Understanding attacker use:

> Helps defenders anticipate threats.

---

## 🔹 SECTION 6: Performance & Optimization

---

### 1️⃣8️⃣ What are timing templates?

| Template | Speed     | Stealth       |
| -------- | --------- | ------------- |
| -T0      | Very slow | Very stealthy |
| -T3      | Default   | Balanced      |
| -T4      | Fast      | Moderate      |
| -T5      | Very fast | Noisy         |

---

### 1️⃣9️⃣ How to reduce scan time?

* Limit ports (-p 1-1000)
* Use host discovery (-sn)
* Use -T4
* Scan only live hosts

---

## 🔹 SECTION 7: Security & Legal Considerations

---

### 2️⃣0️⃣ What are ethical scanning rules?

✔ Only scan authorized systems
✔ Avoid production disruption
✔ Document activity
✔ Follow legal frameworks
✔ Avoid scanning random internet targets

Scanning without permission:

> Can be illegal.

---

## 🔹 SECTION 8: Scenario-Based Questions

---

### Scenario 1:

You discover port 8080 open on a server. What do you do?

**Answer:**

1. Run:

```
nmap -sV -p 8080 target
```

2. Identify service
3. Research version vulnerabilities
4. Check if authorized
5. Escalate findings

---

### Scenario 2:

You suspect lateral movement in a network. What scan do you run?

**Answer:**

* Host discovery across subnet
* Compare open ports
* Identify unusual services
* Look for RDP/SMB/SSH exposure

Example:

```
nmap -sn 172.31.10.0/24
```

---

## 🔹 SECTION 9: Professional-Level Summary

---

### Skills Demonstrated in This Lab

* Host discovery scanning
* TCP & UDP enumeration
* SYN stealth scanning
* Service fingerprinting
* OS detection
* NSE scripting
* Bash automation
* Multi-target scanning
* Structured reporting
* Results aggregation

---

### Why This Lab Is Important

This lab simulates real-world reconnaissance used in:

* Incident Response
* Red Team Operations
* Penetration Testing
* Attack Surface Mapping
* SOC Monitoring

---

# 🏁 Final Interview Summary Statement

“In Lab 09, I performed structured network scanning and enumeration using Nmap. I implemented multiple scan types including SYN, UDP, service detection, OS fingerprinting, and NSE vulnerability scripts. I also developed automated Bash scripts for repeatable scanning workflows and multi-target enumeration. This demonstrates both offensive reconnaissance understanding and defensive incident response capability.”

---

If you say **next**, I will now generate:

📄 `commands.sh`
(clean final organized command list for Lab 09, fully structured, production-ready)
