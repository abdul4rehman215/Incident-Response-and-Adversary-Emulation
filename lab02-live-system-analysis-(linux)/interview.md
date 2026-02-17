# 📘 Interview Q&A — Lab 02: Live System Analysis (Linux)

---

## Q1. What is the purpose of auditd in Linux?

**Answer:**  
Auditd is the Linux auditing daemon responsible for monitoring and logging system activity. It records security-relevant events such as authentication attempts, file access, process execution, privilege escalation, and configuration changes. It is widely used for compliance, forensic investigations, and incident response.

---

## Q2. How do you verify that audit rules are loaded correctly?

**Answer:**  
Use the following command:

```bash
sudo auditctl -l
````

This lists all active audit rules currently loaded into the kernel.

---

## Q3. What command is used to search audit logs by rule key?

**Answer:**

```bash
ausearch -k <key>
```

Example:

```bash
sudo ausearch -k identity
```

This filters audit events associated with the specified rule key.

---

## Q4. Why is it important to back up audit configuration files?

**Answer:**
Backing up configuration files ensures that the original state can be restored if misconfiguration occurs. Incorrect audit rules can cause excessive logging, system instability, or missed security events.

---

## Q5. What type of events were monitored with the key `process_execution`?

**Answer:**
All process execution events triggered by the `execve` system call (both 64-bit and 32-bit architectures) were monitored. This allows tracking of every command executed on the system.

---

## Q6. How can you identify failed system calls in audit logs?

**Answer:**

```bash
sudo ausearch -m SYSCALL -sv no
```

This command filters audit logs to display system calls that were unsuccessful.

---

## Q7. What is the purpose of log correlation in forensic analysis?

**Answer:**
Log correlation connects related events across multiple log sources (audit logs, auth logs, syslog, etc.) to identify patterns that may indicate malicious activity. It improves visibility and detection accuracy.

---

## Q8. Which files are commonly analyzed for authentication events?

**Answer:**

* `/var/log/auth.log`
* `/var/log/audit/audit.log`

These logs record login attempts, SSH access, sudo usage, and authentication failures.

---

## Q9. What is a common indicator of compromise (IOC) related to SSH?

**Answer:**
Multiple failed SSH login attempts may indicate a brute-force attack or credential stuffing attempt.

---

## Q10. Why is threat hunting important in live system analysis?

**Answer:**
Threat hunting proactively searches for hidden threats, persistence mechanisms, suspicious processes, and privilege escalation attempts before they escalate into major security incidents.

---

## Q11. What are SUID and SGID files, and why are they important in forensic analysis?

**Answer:**
SUID (Set User ID) and SGID (Set Group ID) files run with elevated privileges. Unauthorized or unexpected SUID/SGID files may indicate privilege escalation techniques used by attackers.

---

## Q12. Why is real-time monitoring critical in live forensic environments?

**Answer:**
Live systems continuously generate activity. Real-time monitoring ensures rapid detection of abnormal behavior and prevents attackers from maintaining persistence.

---

## Q13. What is the benefit of using automated forensic scripts?

**Answer:**
Automation:

* Reduces human error
* Speeds up evidence collection
* Ensures consistency
* Preserves structured documentation
* Enables repeatable forensic procedures

---

## Q14. How does auditd support incident response teams?

**Answer:**
Auditd provides:

* Detailed event logs
* Process tracking
* File change monitoring
* Privilege escalation tracking
* Authentication monitoring

These logs assist in reconstructing timelines during security investigations.

---

## Q15. What would you improve in a production environment after this lab?

**Answer:**

* Forward audit logs to a centralized SIEM
* Implement alerting thresholds
* Enable log retention policies
* Integrate automated response mechanisms
* Deploy network intrusion detection systems

---

# 🎯 Key Concepts Demonstrated

* Linux live system forensics
* Audit rule configuration
* Event correlation
* Threat hunting methodology
* IOC identification
* Professional forensic reporting

---

# 🚀 Summary

This lab demonstrates practical forensic analysis techniques on a live Linux system using auditd and custom-built automation tools. The skills practiced here are directly applicable in real-world SOC and incident response roles.
