# 🛠 Troubleshooting Guide – Lab 16: Privilege Escalation with Mimikatz (Simulated Environment)

---

# 1️⃣ Wine Compatibility Issues

## ❗ Issue

Mimikatz fails to launch under Wine.

## 🔍 Symptoms

- `wine mimikatz.exe` crashes
- Missing DLL errors
- Console closes immediately
- .NET dependency errors

## 🧪 Diagnosis

Check Wine version:

```bash
wine --version
````

Verify Wine configuration:

```bash
winecfg
```

Check Windows version setting (must be Windows 10).

Check installed components:

```bash
winetricks list-installed
```

## ✅ Solution

Install required dependencies:

```bash
winetricks win10
winetricks vcrun2019 dotnet48
```

Reconfigure Wine prefix:

```bash
winecfg
```

Ensure 64-bit architecture compatibility if using x64 Mimikatz.

---

# 2️⃣ PowerShell Script Execution Errors

## ❗ Issue

PowerShell script does not execute or throws permission errors.

## 🔍 Symptoms

* "Execution of scripts is disabled"
* Registry access denied
* CIM instance errors
* Missing cmdlets

## 🧪 Diagnosis

Check PowerShell version:

```bash
pwsh --version
```

Test script syntax:

```bash
pwsh -File privilege_check.ps1 -WhatIf
```

Check execution policy:

```bash
pwsh -Command Get-ExecutionPolicy
```

## ✅ Solution

Run with bypass policy:

```bash
pwsh -ExecutionPolicy Bypass -File privilege_check.ps1
```

Ensure PowerShell Core (pwsh) is used instead of Windows PowerShell.

---

# 3️⃣ Python Script Errors

## ❗ Issue

Python scripts fail to execute.

## 🔍 Symptoms

* ModuleNotFoundError
* Permission denied
* File not found
* JSON decoding errors

## 🧪 Diagnosis

Check Python version:

```bash
python3 --version
```

Verify file permissions:

```bash
ls -la script.py
```

Check working directory:

```bash
pwd
```

## ✅ Solution

Make script executable:

```bash
chmod +x script.py
```

Ensure required files exist:

```bash
ls -la credentials.json
```

Run using:

```bash
python3 script.py
```

---

# 4️⃣ Mimikatz Simulation Not Returning Credentials

## ❗ Issue

extract_credentials.py shows 0 credentials found.

## 🔍 Possible Causes

* Simulated dump not created
* Wrong working directory
* Wine not correctly configured
* Regex parsing mismatch

## 🧪 Diagnosis

Verify simulated dump:

```bash
ls -la simulated_lsass.dmp
```

Test Mimikatz manually:

```bash
wine mimikatz.exe
```

Validate output parsing with sample output.

## ✅ Solution

Ensure simulate_credentials.py was executed first.

Confirm mimikatz.exe path is correct.

Adjust regex pattern if output format differs.

---

# 5️⃣ Privilege Escalation Assessment Missing Values

## ❗ Issue

assessment_results.json missing fields.

## 🔍 Cause

Wine environment does not fully emulate Windows registry.

## 🧪 Diagnosis

Test individual registry queries:

```bash
pwsh -Command "Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa'"
```

## ✅ Solution

Understand that some registry paths may not exist in Wine.

Handle exceptions gracefully in PowerShell script.

Use simulation-based validation instead of full Windows registry dependency.

---

# 6️⃣ Hardening Script Fails to Modify Registry

## ❗ Issue

implement_defenses.py does not update registry values.

## 🔍 Symptoms

* No changes in registry
* Errors in PowerShell execution

## 🧪 Diagnosis

Test registry modification manually:

```bash
pwsh -Command "Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name RunAsPPL -Value 1"
```

## ✅ Solution

Ensure:

* PowerShell is running with sufficient privileges
* Registry paths exist in Wine simulation
* Commands are syntactically correct

In simulation environments, registry modification may not persist fully.

---

# 7️⃣ Monitoring Script Not Detecting Mimikatz

## ❗ Issue

monitor_credential_access.py does not generate alerts.

## 🔍 Diagnosis

Test process detection manually:

```bash
pwsh -Command "Get-Process | Where-Object {$_.ProcessName -match 'mimikatz'}"
```

Verify baseline recorded properly.

Check if monitoring loop is running.

## ✅ Solution

Ensure:

* Mimikatz is running during monitoring
* PowerShell returns expected output
* security_alerts.json is writable

Add additional debug prints if necessary.

---

# 8️⃣ JSON Report Formatting Errors

## ❗ Issue

JSON reports cannot be parsed.

## 🔍 Symptoms

* JSONDecodeError
* Invalid formatting

## 🧪 Diagnosis

Validate JSON:

```bash
cat file.json | python3 -m json.tool
```

## ✅ Solution

Ensure:

* Proper indentation in json.dump
* No trailing commas
* Valid Python dictionaries

---

# 9️⃣ Wine Performance or Crash Issues

## ❗ Issue

Wine becomes unstable during execution.

## 🔍 Diagnosis

Check system logs:

```bash
dmesg | tail
```

Verify memory availability:

```bash
free -m
```

## ✅ Solution

Restart Wine:

```bash
wineserver -k
```

Reinitialize Wine prefix if needed:

```bash
rm -rf ~/.wine
winecfg
```

---

# 🔟 LSASS Not Visible in Wine

## ❗ Issue

Get-Process -Name lsass returns nothing.

## 🔍 Cause

Wine does not fully emulate LSASS.

## ✅ Solution

Simulate LSASS-related checks instead of relying on real process memory.

Use mock detection and simulated behavior for lab purposes.

---

# 🧠 Preventive Best Practices

* Always disable WDigest unless required
* Enable LSA Protection
* Use Credential Guard
* Enforce strong password policies
* Monitor privileged process access
* Implement centralized logging
* Deploy endpoint detection solutions
* Regularly audit local administrator accounts
* Use LAPS for password rotation

---

# 🏁 Final Troubleshooting Summary

Common issues in this lab are typically related to:

* Wine simulation limitations
* PowerShell execution policies
* Registry emulation differences
* Missing dependencies
* Script execution permissions

Understanding environmental limitations is critical when simulating Windows security tools on Linux systems.

Systematic validation at each step ensures proper execution and accurate learning outcomes.
