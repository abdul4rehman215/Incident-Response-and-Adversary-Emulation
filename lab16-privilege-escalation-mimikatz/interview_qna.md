# 🎤 Interview Questions – Lab 16  
## Privilege Escalation with Mimikatz (Simulated Environment)

---

# 1️⃣ What is Mimikatz?

Mimikatz is a post-exploitation tool used to extract credentials from Windows systems.

It can retrieve:

- Plaintext passwords
- NTLM hashes
- Kerberos tickets
- PIN codes
- LSA secrets

It primarily targets the LSASS (Local Security Authority Subsystem Service) process memory.

---

# 2️⃣ What is LSASS?

LSASS (Local Security Authority Subsystem Service) is a Windows process responsible for:

- Enforcing security policy
- Handling authentication
- Storing credential material in memory
- Managing NTLM and Kerberos authentication

Because LSASS contains sensitive credential data, it is a high-value target for attackers.

---

# 3️⃣ How Does Mimikatz Extract Credentials?

Mimikatz:

1. Elevates privileges (privilege::debug)
2. Accesses LSASS process memory
3. Extracts credential structures
4. Parses authentication packages
5. Displays plaintext passwords and NTLM hashes

Common modules:

- sekurlsa::logonpasswords
- lsadump::sam
- kerberos::list

---

# 4️⃣ What is NTLM Hash?

NTLM (NT LAN Manager) hash is:

- A hashed representation of a Windows password
- Used in challenge-response authentication
- Based on MD4 hashing of UTF-16LE password

Even without plaintext passwords, NTLM hashes can be:

- Used in Pass-the-Hash attacks
- Cracked offline using brute-force or rainbow tables

---

# 5️⃣ What Is WDigest and Why Is It Dangerous?

WDigest is a Windows authentication protocol.

If enabled with:

UseLogonCredential = 1

It stores plaintext credentials in memory.

This makes extraction trivial using tools like Mimikatz.

Best practice:

Disable WDigest unless explicitly required.

---

# 6️⃣ What Is LSA Protection (RunAsPPL)?

LSA Protection (RunAsPPL):

- Runs LSASS as a Protected Process Light (PPL)
- Prevents unauthorized processes from accessing LSASS memory
- Mitigates credential dumping attacks

If disabled:

LSASS can be accessed by privileged users or malware.

---

# 7️⃣ What Is Credential Guard?

Credential Guard:

- Uses virtualization-based security (VBS)
- Isolates secrets from LSASS
- Protects NTLM hashes and Kerberos tickets

Requirements:

- Windows 10 Enterprise
- TPM 2.0
- Secure Boot enabled

It significantly reduces credential theft risk.

---

# 8️⃣ What Is Pass-the-Hash?

Pass-the-Hash (PtH) is an attack technique where:

- An attacker uses NTLM hash directly
- No need to crack the password
- Authentication occurs using the hash

It allows lateral movement without knowing plaintext credentials.

---

# 9️⃣ What Are Common Privilege Escalation Vectors?

Examples:

- Weak service permissions
- Misconfigured registry settings
- Disabled LSA protection
- Enabled WDigest
- Token impersonation
- Unpatched vulnerabilities
- Weak local administrator passwords

---

# 🔟 Why Is Automation Important in Privilege Escalation Assessment?

Automation allows:

- Faster security posture analysis
- Repeatable assessments
- Reduced human error
- Scalable auditing across systems
- Standardized reporting

In this lab, automation was implemented via:

- Python extraction scripts
- PowerShell enumeration tools
- Hardening scripts
- Monitoring scripts

---

# 1️⃣1️⃣ What Defensive Measures Prevent Credential Theft?

Key controls:

- Disable WDigest
- Enable LSA Protection
- Enable Credential Guard
- Implement LAPS
- Enforce strong password policies
- Enable audit logging
- Monitor LSASS access
- Deploy EDR solutions

---

# 1️⃣2️⃣ What Logs Indicate Credential Theft Attempts?

Indicators include:

- Event ID 4625 (Failed Logon)
- Event ID 4672 (Special privileges assigned)
- Event ID 4688 (Process creation – mimikatz.exe)
- Abnormal LSASS memory usage
- Suspicious PowerShell activity

---

# 1️⃣3️⃣ How Does Least Privilege Help Prevent Escalation?

Least privilege:

- Limits user access rights
- Prevents attackers from escalating privileges easily
- Reduces blast radius of compromise
- Restricts access to LSASS memory

---

# 1️⃣4️⃣ What Is the Role of LAPS?

LAPS (Local Administrator Password Solution):

- Randomizes local admin passwords
- Rotates passwords automatically
- Stores credentials securely in Active Directory
- Prevents lateral movement via reused admin passwords

---

# 1️⃣5️⃣ How Would You Detect Mimikatz in a Production Environment?

Detection strategies:

- Monitor LSASS memory access
- Detect unusual handle requests
- Monitor process injection activity
- Alert on mimikatz.exe execution
- Detect suspicious PowerShell commands
- Use EDR telemetry for credential dumping patterns

---

# 1️⃣6️⃣ Why Is Credential Theft a Critical Threat?

Because credentials allow attackers to:

- Escalate privileges
- Move laterally
- Access domain controllers
- Extract sensitive data
- Maintain persistence
- Deploy ransomware

Credential compromise often leads to full domain takeover.

---

# 1️⃣7️⃣ What Is Defense-in-Depth in This Context?

Defense-in-depth means:

Layer 1 – Secure configuration  
Layer 2 – Monitoring  
Layer 3 – Access control  
Layer 4 – Auditing  
Layer 5 – Endpoint detection  

Even if one control fails, others mitigate impact.

---

# 🏁 Final Interview Summary

This lab demonstrated:

- Credential storage in LSASS
- NTLM hash extraction simulation
- Privilege escalation risk analysis
- Hardening implementation
- Continuous monitoring for credential theft

Understanding both attack techniques and defensive countermeasures is essential for:

- SOC Analysts
- Incident Responders
- Blue Team Engineers
- Red Team Operators
- Windows Security Administrators
- Cloud Security Engineers

Credential security is foundational to enterprise defense strategy.
