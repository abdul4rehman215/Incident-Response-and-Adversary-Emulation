# 📘 Interview Q&A – Lab 05: ## Incident Detection with Suricata

---

## Q1. What is Suricata and what is its primary role?

**Answer:**  
Suricata is an open-source Network Intrusion Detection and Prevention System (NIDS/NIPS).  
Its primary role is to monitor network traffic in real time and detect malicious activity using signature-based and protocol-aware inspection.

---

## Q2. Which command is used to validate Suricata configuration before starting it?

**Answer:**  
```bash
suricata -T -c /etc/suricata/suricata.yaml -v
````

This command tests the configuration file and validates all rule files before running Suricata in detection mode.

---

## Q3. What is the purpose of the HOME_NET variable in Suricata?

**Answer:**
`HOME_NET` defines the internal network range that Suricata protects.
Rules referencing `$HOME_NET` apply specifically to internal assets, helping distinguish internal vs external traffic.

Example:

```yaml
vars:
  address-groups:
    HOME_NET: "[172.16.0.0/12,10.0.0.0/8,192.168.1.0/24]"
```

---

## Q4. Which Suricata log file contains detailed JSON-formatted events?

**Answer:**
`eve.json`

This file contains structured event data including:

* Alerts
* Flow records
* DNS events
* HTTP events
* TLS events
* File metadata

It is commonly parsed using `jq` or Python for automated analysis.

---

## Q5. How can you filter only alert events from eve.json?

**Answer:**

Using `jq`:

```bash
sudo cat /var/log/suricata/eve.json | jq 'select(.event_type=="alert")'
```

This extracts only intrusion detection alerts from the log.

---

## Q6. How was SSH brute force detected in this lab?

**Answer:**
A custom rule was created using threshold detection:

```rule
alert tcp any any -> $HOME_NET 22 (msg:"Potential SSH Brute Force";
flags:S; threshold:type both, track by_src, count 5, seconds 60;
sid:1000003; rev:1;)
```

This rule triggers when 5 SYN packets are detected from the same source within 60 seconds.

---

## Q7. What is the purpose of custom rule SIDs (e.g., 1000001)?

**Answer:**
SIDs (Signature IDs) uniquely identify detection rules.

* Prevent conflicts with default rule sets
* Allow tracking of rule performance
* Enable filtering by rule ID

Custom rule best practice:

* Use SID range above 1,000,000

---

## Q8. How can Suricata alerts be monitored in real time?

**Answer:**

Using a live monitoring script:

```bash
sudo tail -f /var/log/suricata/eve.json
```

Or parsing dynamically with:

```bash
jq 'select(.event_type=="alert")'
```

This allows SOC analysts to observe threats as they occur.

---

## Q9. What does severity level indicate in Suricata alerts?

**Answer:**

Severity represents the threat impact level:

| Severity | Meaning |
| -------- | ------- |
| 1        | High    |
| 2        | Medium  |
| 3        | Low     |

Severity helps prioritize incident response actions.

---

## Q10. Why is rule performance analysis important in a SOC environment?

**Answer:**

Rule performance analysis helps:

* Measure detection effectiveness
* Identify noisy or false-positive rules
* Optimize rule sets
* Improve detection coverage
* Reduce alert fatigue

In this lab, custom rule coverage reached **100%**, validating proper rule engineering.

---

## Q11. What is the difference between fast.log and eve.json?

**Answer:**

| File     | Purpose                                                           |
| -------- | ----------------------------------------------------------------- |
| fast.log | Human-readable quick alert summary                                |
| eve.json | Structured JSON event logging for automation and SIEM integration |

---

## Q12. How can Suricata be tuned for performance optimization?

**Answer:**

* Adjust thread settings in `suricata.yaml`
* Tune AF-PACKET cluster mode
* Configure log rotation
* Reduce unnecessary rule sets
* Monitor memory usage via `stats.log`

---

## Q13. What real-world role does Suricata play in cybersecurity operations?

**Answer:**

Suricata is commonly deployed in:

* Security Operations Centers (SOC)
* Threat Hunting Teams
* Enterprise Network Monitoring
* Cloud Security Monitoring
* Incident Response environments

It provides visibility into malicious traffic patterns and enables rapid response.

---

## 🎯 Key Takeaway

This lab demonstrated:

* Intrusion detection engineering
* Custom rule creation
* Real-time alert monitoring
* Automated log analysis
* Incident response workflow
* Performance tuning and rule optimization

Suricata is a powerful tool for modern network defense operations.
