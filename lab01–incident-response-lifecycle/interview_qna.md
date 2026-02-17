# 📘 Interview Q&A – Lab 01: Incident Response Lifecycle

---

## Q1. What are the main phases of the Incident Response lifecycle?

**Answer:**  
The main phases are:

1. Detection  
2. Containment  
3. Recovery  
4. Documentation  

These phases align with the NIST Incident Response Framework, which emphasizes preparation, identification, containment, eradication, recovery, and lessons learned.

---

## Q2. Why is establishing a baseline important in incident response?

**Answer:**  
A baseline represents the system’s normal behavior. It allows security teams to compare current system activity against expected behavior. Without a baseline, it is difficult to identify anomalies such as unusual CPU usage, unknown processes, unauthorized services, or abnormal network activity.

---

## Q3. Which command was used to capture active network connections?

**Answer:**  
The following command was used:

```bash
ss -tuln
```

This command lists TCP and UDP listening ports and helps identify exposed services or suspicious open ports.

---

## Q4. How was high CPU usage detected during the lab?

**Answer:**  
High CPU usage was detected using:

```bash
top -bn1
ps aux
```

The `yes` process was identified consuming nearly 100% CPU, indicating abnormal system behavior.

---

## Q5. What is an Indicator of Compromise (IOC)?

**Answer:**  
An Indicator of Compromise (IOC) is evidence that suggests a system may have been breached. Examples include:

- Suspicious processes
- Unauthorized file creation
- Malicious IP addresses
- Unusual network traffic patterns

In this lab, the IOCs included:
- A high CPU `yes` process
- Suspicious files in `/tmp`
- A simulated suspicious IP address

---

## Q6. Why is volatile evidence collected before containment?

**Answer:**  
Volatile evidence (such as running processes, memory information, open files, and network connections) can disappear after system shutdown or process termination. Collecting it before containment ensures critical forensic data is preserved.

---

## Q7. How were suspicious processes terminated during containment?

**Answer:**  
Two methods were used:

```bash
kill -9 <PID>
pkill -f yes
```

This ensured both the targeted process and any remaining related processes were terminated.

---

## Q8. What does quarantining a file mean in incident response?

**Answer:**  
Quarantining involves moving suspicious files to a secure directory to prevent execution while preserving them as evidence for forensic analysis.

In this lab, suspicious files were moved to:

```
incident_response/evidence/quarantine/
```

---

## Q9. What is AIDE and why was it used?

**Answer:**  
AIDE (Advanced Intrusion Detection Environment) is a file integrity monitoring tool. It creates a baseline of file hashes and detects unauthorized modifications.

In this lab, AIDE was used to:

- Initialize an integrity baseline
- Update the integrity database during hardening
- Ensure system files had not been altered maliciously

---

## Q10. What was the purpose of the recovery verification script?

**Answer:**  
The recovery verification script ensured:

- No malicious processes were running
- Suspicious files were successfully quarantined
- CPU and memory usage returned to normal
- Network connections were legitimate

This confirms the system returned to a stable operational state.

---

## Q11. Why is documentation critical in incident response?

**Answer:**  
Documentation ensures:

- Accountability
- Audit trail creation
- Compliance with regulatory requirements
- Knowledge transfer
- Lessons learned for future improvements

Professional documentation also supports legal proceedings if required.

---

## Q12. What improvements can be implemented after recovery?

**Answer:**  

Post-incident improvements include:

- Continuous monitoring
- Log rotation automation
- Enhanced alerting mechanisms
- Staff training
- Automated response integration
- Security policy refinement

---

## Q13. How does this lab align with the NIST framework?

**Answer:**  

The lab aligns as follows:

- **Preparation:** Tool installation and directory structure setup  
- **Identification:** Baseline creation and anomaly detection  
- **Containment:** Process termination and file quarantine  
- **Eradication:** Removal of malicious artifacts  
- **Recovery:** System verification and hardening  
- **Lessons Learned:** Documentation and reporting  

---

## Q14. What role does continuous monitoring play after recovery?

**Answer:**  

Continuous monitoring ensures:

- Early detection of future threats
- Alerting on abnormal CPU usage
- Detection of suspicious files in sensitive directories
- Ongoing system integrity verification

It shifts the system from reactive to proactive security posture.

---

## Q15. Why is evidence preservation important?

**Answer:**  

Evidence preservation ensures:

- Forensic integrity
- Root cause analysis capability
- Chain-of-custody maintenance
- Legal defensibility
- Accurate reporting and investigation

Without preserved evidence, investigation accuracy is compromised.

---

# 🏁 Summary

This lab demonstrates:

- Practical incident detection
- Structured containment
- Forensic evidence handling
- Recovery validation
- System hardening
- Professional documentation practices

It reflects real-world blue team incident response methodology in a controlled Linux environment.

---
