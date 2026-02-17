# 🎤 Interview Questions & Answers - Lab 12 – Brute-Force and Credential Stuffing Attacks

---

## 1️⃣ What is a brute-force attack?

A brute-force attack is an authentication attack method where an attacker systematically attempts multiple username and password combinations until the correct credentials are discovered.

It relies on:
- Automated tools
- Weak password policies
- Lack of rate limiting
- Default credentials

In this lab, Hydra was used to automate brute-force attacks against FTP and HTTP services.

---

## 2️⃣ What is the difference between brute-force and credential stuffing?

| Brute-Force Attack | Credential Stuffing |
|--------------------|--------------------|
| Tries many password combinations for one or more users | Uses known username:password pairs from data breaches |
| Relies on guessing | Relies on password reuse |
| Can take longer | Often very fast if reuse exists |
| High volume attempts | Targeted reuse attempts |

In this lab:
- Hydra demonstrated brute-force attacks.
- A Bash script demonstrated credential stuffing using known credential pairs.

---

## 3️⃣ What is Hydra and how does it work?

Hydra is a parallelized login cracking tool that supports numerous protocols including:

- FTP
- SSH
- HTTP
- SMB
- RDP
- Telnet

Hydra works by:
1. Taking username and password inputs
2. Attempting authentication against a service
3. Reporting successful login combinations

Example used in this lab:

```bash
hydra -L userlist.txt -P passlist.txt 127.0.0.1 ftp
```

This attempts all combinations from userlist and passlist.

---

## 4️⃣ What is the impact of weak passwords?

Weak passwords allow:

- Rapid brute-force compromise
- Dictionary-based cracking
- Credential stuffing exploitation
- Lateral movement across services

In this lab, the following weak credentials were compromised:

- admin : admin
- testuser1 : password123
- webuser : password

This demonstrates real-world risk of:

- Default credentials
- Short passwords
- Dictionary passwords
- Password reuse

---

## 5️⃣ Why is rate limiting important?

Rate limiting restricts the number of login attempts within a time window.

Without rate limiting:
- Attackers can attempt unlimited passwords
- Automated tools can brute-force rapidly
- Detection becomes harder

In this lab:
- FTP and HTTP had no rate limiting
- 20 failed attempts completed without blocking
- System was vulnerable until Fail2Ban was enabled

---

## 6️⃣ What is Fail2Ban and how does it protect systems?

Fail2Ban is an intrusion prevention tool that:

- Monitors log files
- Detects repeated failed login attempts
- Automatically bans IP addresses

Configuration used in this lab:

```ini
[vsftpd]
enabled = true
maxretry = 3
bantime = 600
```

After multiple failed login attempts, the IP address was successfully banned.

This demonstrates active defense against brute-force attacks.

---

## 7️⃣ What are common defensive measures against brute-force attacks?

### Immediate Controls:
- Account lockout after 3–5 failed attempts
- Rate limiting
- IP banning
- Strong password enforcement

### Advanced Controls:
- Multi-Factor Authentication (MFA)
- CAPTCHA protection
- Web Application Firewalls (WAF)
- Behavioral anomaly detection

---

## 8️⃣ Why is credential stuffing dangerous?

Credential stuffing exploits:

- Password reuse across services
- Previously leaked credentials
- Weak authentication monitoring

In real-world attacks:
- Attackers use millions of breached credentials
- Automated scripts test across multiple websites
- Success rates increase due to password reuse

This lab simulated real-world credential stuffing behavior.

---

## 9️⃣ What professional roles require knowledge of these techniques?

These skills are essential for:

- Penetration Testers
- Red Team Operators
- SOC Analysts
- Incident Responders
- Security Engineers
- Threat Hunters

Understanding attack techniques helps:

- Improve defenses
- Assess vulnerabilities
- Conduct authorized security testing

---

## 🔟 What is the real-world significance of this lab?

This lab reflects real-world attack patterns where:

- Default credentials are exploited
- Automated tools increase attack speed
- Weak authentication policies lead to breaches
- Defense mechanisms drastically reduce attack success

Key takeaway:

Authentication security is one of the most critical components of cybersecurity posture.

---

# 🏁 Final Interview Summary

This lab demonstrates practical knowledge of:

✔ Brute-force attack methodology  
✔ Credential stuffing techniques  
✔ Hydra usage and automation  
✔ Authentication weakness analysis  
✔ Rate limiting evaluation  
✔ Fail2Ban defensive configuration  
✔ Security reporting and documentation  

These are real-world, job-relevant skills for modern cybersecurity professionals.

---
