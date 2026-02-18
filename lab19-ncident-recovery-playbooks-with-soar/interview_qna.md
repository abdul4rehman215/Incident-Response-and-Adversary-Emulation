# 🎤 Interview Questions & Answers  
Lab 19 – Incident Recovery Playbooks with SOAR

---

## 1️⃣ What is SOAR and how does it differ from SIEM?

**Answer:**

SOAR (Security Orchestration, Automation, and Response) is a platform designed to automate and orchestrate incident response workflows.

SIEM:
- Collects and correlates logs
- Generates alerts
- Focuses on detection

SOAR:
- Takes alerts from SIEM
- Automates investigation steps
- Executes containment and remediation
- Reduces manual analyst effort

SIEM detects.
SOAR responds.

---

## 2️⃣ What components were deployed in this lab?

**Answer:**

The lab deployed:

- Elasticsearch (data storage and search engine)
- TheHive (incident case management platform)
- Cortex (analysis engine for observables)
- Python-based playbooks (automation logic)
- SIEM integration script (alert ingestion simulation)

All deployed using Docker Compose.

---

## 3️⃣ Why is Elasticsearch required for TheHive and Cortex?

**Answer:**

Elasticsearch provides:

- Fast indexing and searching of incident data
- Storage for observables and case metadata
- Scalable backend for large SOC environments

TheHive and Cortex rely on Elasticsearch as their search and data backend.

---

## 4️⃣ What is a playbook in SOAR?

**Answer:**

A playbook is an automated workflow that:

- Defines response steps
- Executes containment actions
- Documents decisions
- Standardizes incident handling

It converts manual IR procedures into automated logic.

In this lab:
- Malware response playbook
- Phishing response playbook

---

## 5️⃣ How did the malware playbook perform containment?

**Answer:**

It performed:

- Case creation
- Observable enrichment
- Hash analysis (simulated threat scoring)
- Host isolation simulation
- Indicator blocking simulation

Containment was triggered when threat score > 70.

---

## 6️⃣ What containment actions were simulated?

**Answer:**

- Host isolation via firewall block
- Indicator blocking
- URL blocking (phishing case)
- Email quarantine
- User notification

These simulate real-world SOC containment strategies.

---

## 7️⃣ How does automation reduce incident response time?

**Answer:**

Automation:

- Removes manual repetitive steps
- Executes containment instantly
- Standardizes response
- Reduces analyst fatigue
- Minimizes human error

In real SOC environments, automation can reduce MTTR significantly.

---

## 8️⃣ What risks exist when automating incident response?

**Answer:**

- False positives causing unnecessary isolation
- Blocking legitimate traffic
- Over-automation without validation
- Lack of human oversight
- Poorly tested workflows causing outages

Proper validation and testing is critical.

---

## 9️⃣ How can SOAR improve audit and compliance?

**Answer:**

SOAR provides:

- Structured execution logs
- Timestamped actions
- Automated documentation
- Standardized procedures
- Evidence tracking

This improves compliance with frameworks such as:

- ISO 27001
- NIST 800-61
- SOC 2

---

## 🔟 What is orchestration vs automation?

**Answer:**

Automation:
- Automates a single task

Orchestration:
- Connects multiple systems
- Executes multi-step workflows
- Coordinates tools

Example:
- Automation = block IP
- Orchestration = detect → analyze → isolate → notify → document

---

## 1️⃣1️⃣ Why was Docker used in this lab?

**Answer:**

Docker provides:

- Service isolation
- Reproducible environments
- Easy deployment
- Scalability
- Dependency management

Modern SOC tools are frequently containerized.

---

## 1️⃣2️⃣ How does SIEM integration enhance SOAR?

**Answer:**

SIEM generates alerts.

SOAR:

- Consumes alerts
- Categorizes incidents
- Executes playbooks
- Applies response logic

This creates end-to-end detection and response automation.

---

## 1️⃣3️⃣ What real-world improvements could be added?

**Answer:**

Enhancements could include:

- Real VirusTotal API integration
- Real firewall API integration
- Active Directory integration
- EDR integration
- Ticketing system integration
- Slack or Teams alerting
- Case status management

---

## 1️⃣4️⃣ What metrics are improved by SOAR?

**Answer:**

- MTTR (Mean Time to Respond)
- MTTD (Mean Time to Detect)
- Analyst workload
- Consistency of response
- Compliance traceability

---

## 1️⃣5️⃣ What would you explain to management about SOAR value?

**Answer:**

SOAR:

- Reduces response time
- Standardizes incident handling
- Reduces operational cost
- Improves audit readiness
- Scales SOC operations
- Reduces burnout

It transforms reactive security into structured automated defense.

---

## 1️⃣6️⃣ How does this lab prepare you for real SOC roles?

**Answer:**

This lab demonstrates:

- Incident lifecycle automation
- Workflow design
- Tool integration
- Containment logic
- Response validation
- Docker deployment
- Backend service verification

These are real-world SOC engineering skills.

---

## 🎯 Final Interview Takeaway

Understanding SOAR means understanding:

- Detection is not enough
- Response must be fast
- Automation must be safe
- Workflows must be structured
- Audit trails must be preserved

Automation strengthens defense — when implemented responsibly.

