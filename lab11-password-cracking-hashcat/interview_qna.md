# 🎤 Interview QNA - Lab 11: Password Cracking with Hashcat

---

## 1️⃣ What is Hashcat?

Hashcat is an advanced password recovery tool used for cracking password hashes using various attack modes such as:

- Dictionary attacks
- Brute-force attacks
- Rule-based attacks
- Combination attacks
- Mask attacks

It supports GPU acceleration via OpenCL and CUDA, making it one of the fastest password cracking tools available.

---

## 2️⃣ What is the difference between hashing and encryption?

| Hashing | Encryption |
|----------|------------|
| One-way process | Two-way process |
| Cannot be reversed | Can be decrypted with a key |
| Used for password storage | Used for secure communication |
| Example: MD5, SHA-256 | Example: AES, RSA |

Hashing ensures passwords are not stored in plaintext.

---

## 3️⃣ Why is MD5 considered weak?

MD5 is considered weak because:

- Extremely fast to compute
- Vulnerable to collision attacks
- Easily cracked using GPU acceleration
- No built-in salting mechanism
- Massive rainbow tables exist

In this lab:
MD5 speed ≈ 28 GH/s → Extremely fast to crack.

---

## 4️⃣ Why was SHA-256 slower than MD5?

SHA-256 uses a more complex hashing algorithm with more computational steps.

Lab Observation:
- MD5 ≈ 125 MH/s (dictionary test)
- SHA-256 ≈ 850 kH/s

Even though SHA-256 is slower, it is still crackable if:
- Password is weak
- No salt is used

---

## 5️⃣ What makes bcrypt much stronger than MD5 or SHA-256?

bcrypt is:

- Designed specifically for password hashing
- Intentionally slow
- Includes built-in salting
- Configurable work factor (cost)

Benchmark Results:
- MD5 → 28 GH/s
- SHA-256 → 950 MH/s
- bcrypt → 950 H/s

bcrypt is millions of times slower → significantly more secure.

---

## 6️⃣ What are the main attack modes used in this lab?

### 1️⃣ Dictionary Attack (-a 0)
Uses a wordlist to match common passwords.

### 2️⃣ Brute Force Attack (-a 3)
Attempts every possible combination using masks.

Example:
`?l?l?l → lowercase 3 characters`
`?d?d?d → 3 digits`

### 3️⃣ Rule-Based Attack (-r)
Applies transformation rules to wordlists.

Example:
- Add numbers
- Capitalize first letter
- Append symbols

### 4️⃣ Combination Attack (-a 1)
Combines two wordlists together.

---

## 7️⃣ What is GPU acceleration in Hashcat?

GPU acceleration uses graphics cards to:

- Perform parallel hash computations
- Dramatically increase cracking speed
- Reduce time required for brute force attacks

Lab Result:
CPU → ~2.48 seconds
GPU → ~0.21 seconds

GPU was ~10x faster in this test.

---

## 8️⃣ What is salting and why is it important?

Salting:

- Adds random data to passwords before hashing
- Prevents rainbow table attacks
- Ensures identical passwords produce different hashes

Without salting:
Two users with the same password will have identical hashes.

---

## 9️⃣ What is workload profile in Hashcat?

Workload profile controls GPU intensity:

- `--workload-profile 1` → Low
- `--workload-profile 2` → Medium
- `--workload-profile 3` → High (used in lab)

Higher workload increases performance but may increase GPU temperature.

---

## 🔟 What real-world scenarios use password cracking?

### Incident Response
- Analyze leaked credential dumps
- Identify compromised accounts

### Penetration Testing
- Evaluate password policy strength

### Digital Forensics
- Recover credentials from seized systems

### Security Audits
- Validate password complexity enforcement

---

## 1️⃣1️⃣ Why is password cracking important for defenders?

Understanding cracking techniques helps defenders:

- Enforce stronger password policies
- Implement secure hashing algorithms
- Deploy MFA
- Detect credential stuffing risks

---

## 1️⃣2️⃣ What are best practices for password security?

✔ Use bcrypt or Argon2  
✔ Always use salts  
✔ Enforce strong password policies  
✔ Implement multi-factor authentication  
✔ Monitor credential leaks  
✔ Use rate limiting  

---

## 🎯 Key Technical Takeaways

- Weak passwords are cracked instantly
- GPU acceleration dramatically increases attack power
- Hash algorithm choice is critical
- Dictionary + rules are very effective
- bcrypt provides significantly stronger defense

---

## 🏁 Interview Summary

This lab demonstrates practical knowledge of:

- Hash analysis
- GPU-accelerated cracking
- Attack mode selection
- Performance benchmarking
- Password policy evaluation

These skills are highly relevant for:

- SOC Analysts
- Incident Responders
- Red Teamers
- Penetration Testers
- Security Engineers

---
