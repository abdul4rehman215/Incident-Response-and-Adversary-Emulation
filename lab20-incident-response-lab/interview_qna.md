# 🎤 Interview Questions & Answers - Lab 20: Final Incident Response Simulation

---

## 1️⃣ What is the role of a Security Operations Center (SOC)?

A Security Operations Center (SOC) is responsible for continuously monitoring, detecting, analyzing, and responding to cybersecurity incidents.

Core responsibilities include:

- Monitoring security alerts
- Investigating suspicious activities
- Coordinating incident response
- Performing threat hunting
- Maintaining security tools
- Reporting to management

In this lab, we simulated a full SOC stack using Wazuh, Suricata, and Zeek.

---

## 2️⃣ What is the difference between SIEM, IDS, and Network Monitoring?

### SIEM (Security Information and Event Management)
- Centralized log collection and correlation
- Alert generation
- Compliance reporting
- Example: Wazuh

### IDS (Intrusion Detection System)
- Detects malicious network activity
- Signature-based and behavioral detection
- Example: Suricata

### Network Security Monitoring (NSM)
- Deep visibility into network traffic
- Logs connections, DNS, HTTP activity
- Example: Zeek

This lab integrated all three for multi-layer detection.

---

## 3️⃣ Why integrate Suricata and Zeek into Wazuh?

Integration provides:

- Centralized alert correlation
- Cross-tool visibility
- Unified incident investigation
- Reduced alert blind spots

For example:

- Suricata detected SQL injection attempts
- Zeek logged network connections
- Wazuh correlated and escalated alerts

This multi-tool approach increases detection accuracy.

---

## 4️⃣ What attack vectors were simulated in this lab?

We simulated:

- Port scanning (reconnaissance)
- SQL injection
- Cross-Site Scripting (XSS)
- Directory traversal
- Brute force login attempts
- Malware-like file creation
- Suspicious DNS queries
- Process injection behavior

These represent common real-world threat scenarios.

---

## 5️⃣ How was detection validated?

Detection was validated by:

- Reviewing Wazuh alerts.log
- Checking Suricata fast.log
- Reviewing Zeek conn.log

Multiple tools confirmed the same malicious behaviors, strengthening incident confidence.

---

## 6️⃣ What is the NIST Incident Response Lifecycle?

The NIST framework defines six phases:

1. Preparation
2. Identification
3. Containment
4. Eradication
5. Recovery
6. Lessons Learned

This lab followed these phases exactly through scripted automation.

---

## 7️⃣ What containment measures were implemented?

Containment included:

- Blocking suspicious IP addresses via iptables
- Blocking high-risk ports
- Killing suspicious processes
- Moving suspicious files to quarantine
- Locking critical system files with immutable attribute

These steps prevent lateral movement and further compromise.

---

## 8️⃣ Why is evidence collection important?

Evidence collection ensures:

- Forensic integrity
- Chain-of-custody preservation
- Legal defensibility
- Accurate post-incident analysis

We collected:

- System information
- Running processes
- Network connections
- Wazuh logs
- Suricata logs
- Zeek logs

---

## 9️⃣ What is log correlation?

Log correlation combines multiple log sources to identify patterns that single tools may miss.

Example:

- Zeek logs connection attempts
- Suricata flags suspicious traffic
- Wazuh escalates the alert

Correlated data increases confidence and reduces false positives.

---

## 🔟 Why was immutable attribute applied to /etc/passwd and /etc/shadow?

Using:
`chattr +i /etc/passwd`
`chattr +i /etc/shadow`


Prevents modification of critical authentication files.

This protects against:

- Privilege escalation
- Unauthorized user creation
- Password tampering

This is a containment hardening step.

---

## 1️⃣1️⃣ What is the difference between detection and prevention?

Detection:
- Identifies malicious activity
- Generates alerts

Prevention:
- Blocks malicious activity
- Stops execution

In this lab:
- Suricata detected threats
- iptables enforced containment (prevention)

---

## 1️⃣2️⃣ Why use open-source tools instead of commercial ones?

Open-source tools provide:

- Transparency
- Flexibility
- Cost-effectiveness
- Community support
- Enterprise-level capabilities

Wazuh, Suricata, and Zeek are widely used in real SOC environments.

---

## 1️⃣3️⃣ What professional roles does this lab simulate?

This lab mirrors:

- SOC Analyst
- Incident Response Specialist
- Blue Team Engineer
- Security Operations Engineer
- Detection Engineer

It demonstrates real operational workflows.

---

## 1️⃣4️⃣ How do you verify recovery was successful?

Verification included:

- Checking service status
- Confirming no suspicious processes
- Reviewing firewall rules
- Verifying log generation
- Confirming security posture improvements

This ensures the system is stable and secure.

---

## 1️⃣5️⃣ What is the importance of executive reporting?

Executive reports:

- Communicate risk to leadership
- Translate technical findings into business impact
- Justify security investments
- Demonstrate response effectiveness

The executive_summary.txt fulfills this requirement.

---

## 1️⃣6️⃣ What improvements would you implement in a production SOC?

- Implement SOAR automation
- Add threat intelligence feeds
- Deploy EDR agents across endpoints
- Implement automated containment rules
- Enable real-time alerting dashboards
- Add network segmentation

---

## 1️⃣7️⃣ What is the biggest challenge in real SOC environments?

- Alert fatigue
- False positives
- Tool integration complexity
- Incident prioritization
- Limited response time

Proper log correlation and automation reduce these challenges.

---

## 1️⃣8️⃣ What is the difference between eradication and recovery?

Eradication:
- Remove root cause (malware, vulnerabilities)

Recovery:
- Restore services
- Validate system integrity
- Return to normal operations

Both were executed in separate scripted phases.

---

## 1️⃣9️⃣ Why archive evidence?

Archiving ensures:

- Long-term retention
- Legal defensibility
- Audit readiness
- Incident reconstruction capability

The lab created evidence_archive.tar.gz for this purpose.

---

## 2️⃣0️⃣ What does this lab prove professionally?

This lab proves ability to:

- Deploy SOC infrastructure
- Detect multi-vector attacks
- Perform log correlation
- Execute containment strategies
- Perform system hardening
- Restore services
- Generate professional documentation
- Follow NIST IR lifecycle

This demonstrates readiness for real-world incident response roles.

---

# 🎓 Summary

This lab demonstrates:

✔ Multi-tool security monitoring  
✔ Real-world attack simulation  
✔ Structured incident response  
✔ Evidence preservation  
✔ Executive reporting  
✔ Professional SOC workflow  

It mirrors real enterprise blue team operations.
