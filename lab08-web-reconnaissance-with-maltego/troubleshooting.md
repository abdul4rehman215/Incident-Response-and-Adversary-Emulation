# 🛠 Troubleshooting Guide – Lab 08: Web Reconnaissance with Maltego

> This document outlines common issues encountered during installation, integration, and execution of Maltego and supporting OSINT tools, along with practical solutions.

---

# 1️⃣ Maltego Installation Issues

## ❌ Problem: Maltego fails to install using dpkg

### Possible Causes:
- Missing dependencies
- Corrupted .deb file
- Interrupted installation

### ✅ Solution:

Fix broken dependencies:

```bash
sudo apt-get install -f -y
```

Reconfigure pending packages:

```bash
sudo dpkg --configure -a
```

Re-download Maltego if corrupted:

```bash
rm Maltego.v4.5.0.deb
wget https://maltego-downloads.s3.us-east-2.amazonaws.com/linux/Maltego.v4.5.0.deb
```

---

## ❌ Problem: Maltego does not launch

### Possible Causes:
- Java not installed
- Wrong Java version
- Environment path issue

### ✅ Solution:

Verify Java installation:

```bash
java -version
```

If missing:

```bash
sudo apt install default-jre default-jdk -y
```

Check if maltego binary exists:

```bash
which maltego
```

---

# 2️⃣ Java Runtime Errors

## ❌ Problem: Unsupported Java version error

### Solution:

Install recommended OpenJDK:

```bash
sudo apt install openjdk-21-jdk -y
```

Set default Java:

```bash
sudo update-alternatives --config java
```

---

# 3️⃣ Transform Execution Failures

## ❌ Problem: Transforms return no results

### Possible Causes:
- Internet connectivity issue
- API rate limits
- API keys not configured

### ✅ Solution:

Check connectivity:

```bash
ping -c 4 google.com
```

Verify DNS resolution:

```bash
nslookup example-target.com
```

Check Maltego message log:
View → Show Messages

---

# 4️⃣ theHarvester Issues

## ❌ Problem: theHarvester command not found

### Solution:

Verify installation:

```bash
which theharvester
```

If missing:

```bash
sudo apt install theharvester -y
```

Or install via pip:

```bash
pip3 install theHarvester
```

---

## ❌ Problem: Missing Python modules

### Solution:

Install required modules:

```bash
pip3 install requests beautifulsoup4 dnspython shodan
```

Upgrade pip:

```bash
python3 -m pip install --upgrade pip
```

---

# 5️⃣ Sublist3r Errors

## ❌ Problem: Sublist3r fails to run

### Solution:

Install dependencies:

```bash
cd ~/Sublist3r
pip3 install -r requirements.txt
```

Verify Python version:

```bash
python3 --version
```

---

# 6️⃣ DNSrecon Failures

## ❌ Problem: dnsrecon returns no results

### Possible Causes:
- Domain not resolvable
- Network restrictions

### Solution:

Test DNS manually:

```bash
nslookup example-target.com
```

Try alternative DNS server:

```bash
nslookup example-target.com 8.8.8.8
```

---

# 7️⃣ Recon-ng Module Errors

## ❌ Problem: Module not found

### Solution:

Update marketplace:

```bash
marketplace refresh
```

Install module again:

```bash
marketplace install hackertarget
```

---

# 8️⃣ Custom Transform Errors

## ❌ Problem: XML output malformed

### Solution:

Validate XML structure:

```bash
python3 custom_subdomain_transform.py example-target.com
```

Ensure:
- Proper XML tags
- No indentation errors
- Correct entity type format

---

# 9️⃣ Permission Errors

## ❌ Problem: Permission denied when running scripts

### Solution:

Make executable:

```bash
chmod +x script_name.py
```

Check ownership:

```bash
ls -la
```

---

# 🔟 Memory and Performance Issues

## ❌ Problem: Maltego becomes slow with large graphs

### Causes:
- Large number of entities
- Low Java heap allocation

### Solution:

Increase heap size:
1. Open Maltego
2. Go to Settings → Java
3. Increase memory allocation

Use graph filtering:
- Select → Select by Incoming Link Count
- Hide irrelevant entities

Split investigations into smaller graphs.

---

# 1️⃣1️⃣ API Rate Limiting Issues

## ❌ Problem: APIs stop returning results

### Causes:
- Exceeded free-tier limits
- Too many requests

### Solution:
- Reduce query frequency
- Add delays in automation scripts
- Use rate limiting wrappers
- Register API keys for extended access

---

# 1️⃣2️⃣ Performance Test Failures

## ❌ Problem: Performance test script times out

### Solution:

Increase timeout in script:

```python
timeout=120
```

Test individual commands manually.

---

# 1️⃣3️⃣ GUI Freezing

## ❌ Problem: Maltego GUI freezes

### Solution:

Kill process:

```bash
pkill maltego
```

Restart:

```bash
maltego &
```

Check system resources:

```bash
htop
```

---

# 1️⃣4️⃣ Report Generator Issues

## ❌ Problem: CSV file not found

### Solution:

Export from Maltego:
File → Export → Export to CSV

Ensure filename:
```
maltego_export.csv
```

---

# 1️⃣5️⃣ Network Connectivity Problems

## Test internet connectivity:

```bash
ping -c 4 google.com
```

## Test HTTP connectivity:

```bash
curl -I https://www.google.com
```

## Check firewall rules:

```bash
sudo ufw status
```

---

# ✅ Verification Checklist

Before concluding troubleshooting, confirm:

✔ Java installed and working  
✔ Maltego launches successfully  
✔ All CLI tools respond to --help  
✔ Subdomains enumerate successfully  
✔ Email harvesting works  
✔ Reports generate properly  
✔ Custom transform outputs valid XML  
✔ Performance tests complete  

---

# 🎯 Final Troubleshooting Summary

Most issues encountered in this lab fall into:

1. Dependency problems
2. Permission issues
3. API rate limiting
4. Network connectivity
5. Memory allocation constraints

Systematic troubleshooting ensures:

- Reliable reconnaissance workflow
- Proper tool integration
- Stable automation scripts
- Accurate intelligence collection

---

End of Troubleshooting Guide – Lab 08
