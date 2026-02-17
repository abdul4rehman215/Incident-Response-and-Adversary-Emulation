# 🛠 Troubleshooting Guide – Lab 07: OSINT with theHarvester

This document outlines common issues encountered during installation, execution, automation, and reporting when using theHarvester and related scripts.

---

# 🔧 Issue 1: theHarvester Installation Problems

## ❌ Problem

- theHarvester fails to run
- Python module errors
- "ModuleNotFoundError"
- "No module named..."

## ✅ Solution

### 1️⃣ Ensure Python Version

```bash
which python3
python3 --version
```

Expected:
```
Python 3.12.x
```

---

### 2️⃣ Upgrade pip

```bash
python3 -m pip install --upgrade pip
```

---

### 3️⃣ Install Dependencies Manually

```bash
pip3 install requests beautifulsoup4 plotly matplotlib shodan
```

---

### 4️⃣ Alternative Installation

If cloning fails:

```bash
pip3 install theHarvester
```

Or:

```bash
pip3 install --user theHarvester
```

---

# 🔧 Issue 2: Permission Errors

## ❌ Problem

- Permission denied when running scripts
- Unable to execute `.py` files

## ✅ Solution

### Make Scripts Executable

```bash
chmod +x ~/theHarvester/theHarvester.py
chmod +x *.py
```

---

### Check File Permissions

```bash
ls -la
```

Expected:
```
-rwxr-xr-x 1 toor toor 12345 theHarvester.py
```

---

# 🔧 Issue 3: Network Connectivity Problems

## ❌ Problem

- No results returned
- Timeout errors
- Engine errors
- SSL verification issues

## ✅ Solution

### Test Internet Connectivity

```bash
ping -c 4 google.com
```

---

### Check DNS Resolution

```bash
nslookup example.com
```

---

### Test HTTPS Connectivity

```bash
curl -I https://www.google.com
```

---

If behind firewall or proxy:
- Configure proxy settings
- Check security group rules (if EC2)

---

# 🔧 Issue 4: API Key Configuration Not Working

## ❌ Problem

- Shodan or VirusTotal not returning results
- "Invalid API Key" error

## ✅ Solution

### Verify API Key File Location

```bash
ls -la ~/.theHarvester/
```

Expected file:
```
api-keys.yaml
```

---

### Validate YAML Syntax

Ensure correct format:

```yaml
apikeys:
  shodan: your_shodan_api_key_here
  virustotal: your_virustotal_api_key_here
  hunter: your_hunter_api_key_here
```

---

### Confirm API Key Validity

Test directly via:

```bash
curl https://api.shodan.io/api-info?key=YOUR_API_KEY
```

---

# 🔧 Issue 5: Automation Script Fails

## ❌ Problem

- `subprocess.run` errors
- JSON file not found
- Report not generated

## ✅ Solution

### Ensure Correct Working Directory

In automation script:
```
cwd=os.path.expanduser("~/theHarvester")
```

Verify manually:

```bash
cd ~/theHarvester
ls
```

---

### Check JSON File Exists

```bash
ls -la harvester_reports/
```

If missing:
- Check `-f` output parameter
- Verify scan completed successfully

---

# 🔧 Issue 6: Advanced Processor Not Extracting Data

## ❌ Problem

- Emails count = 0
- Subdomains missing

## ✅ Solution

### Verify Regex Patterns

Email pattern:
```
\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b
```

Subdomain pattern:
```
\b[\w.-]*\.example.com\b
```

---

### Debug Raw Output

Add temporary debug print:

```python
print(output_text)
```

Ensure data is being captured.

---

# 🔧 Issue 7: Visualization Script Errors

## ❌ Problem

- JSON decode error
- KeyError: findings

## ✅ Solution

Verify JSON structure:

```bash
cat comprehensive_report_example.com_*.json
```

Expected format:

```json
{
  "scan_info": {},
  "statistics": {},
  "findings": {
    "emails": [],
    "subdomains": []
  }
}
```

---

# 🔧 Issue 8: Rate Limiting Script Not Working

## ❌ Problem

- Script runs too fast
- No delay between scans

## ✅ Solution

Check delay value:

```python
time.sleep(delay)
```

Ensure `delay` argument is passed correctly.

Example:

```bash
python3 rate_limited_harvest.py example.com google,bing
```

---

# 🔧 Issue 9: No Results Found

## ❌ Problem

- Zero emails
- Zero subdomains

## Possible Causes

- Target domain has limited public exposure
- Search engine blocking automated queries
- Rate limits triggered
- API key invalid

## Recommended Actions

- Use multiple sources
- Reduce request rate
- Use API keys
- Try alternative engines

---

# 🔍 Verification Checklist

### ✔ Verify theHarvester

```bash
python3 theHarvester.py -h
```

---

### ✔ Test Basic Scan

```bash
python3 theHarvester.py -d example.com -l 10 -b google
```

---

### ✔ Test Automation Script

```bash
python3 harvester_automation.py example.com
```

---

### ✔ Verify Reports

```bash
ls -la *.html *.json *.csv
```

---

### ✔ Test Advanced Processor

```bash
python3 advanced_processor.py example.com
```

---

# 🚨 Security Best Practices

- Do not run aggressive scans without authorization
- Avoid excessive request volume
- Use rate limiting
- Store API keys securely
- Document investigation scope
- Respect legal boundaries

---

# 🏁 Final Notes

This lab integrates:

- OSINT collection
- Automation scripting
- Reporting
- Legal compliance
- Ethical reconnaissance
- Incident response simulation
- Adversary emulation workflow

If issues persist:
- Reinstall dependencies
- Re-clone repository
- Validate Python environment
- Review logs carefully

---

End of Troubleshooting Guide – Lab 07
