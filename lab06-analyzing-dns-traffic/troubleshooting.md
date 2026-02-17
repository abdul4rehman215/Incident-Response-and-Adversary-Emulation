# 🛠 Troubleshooting — Lab 6: Analyzing DNS Traffic

---

## 🔹 Issue 1: Permission Denied When Running tcpdump

### ❌ Error:
```

tcpdump: ens5: You don't have permission to capture on that device

````

### ✅ Solution:

Run tcpdump with sudo:

```bash
sudo tcpdump -i ens5 -n port 53
````

OR add your user to the pcap group:

```bash
sudo usermod -a -G pcap $USER
newgrp pcap
```

Then log out and log back in.

---

## 🔹 Issue 2: No Packets Captured

### ❌ Problem:

tcpdump runs but shows no DNS traffic.

### ✅ Troubleshooting Steps:

1. Verify correct interface:

```bash
ip addr show
```

2. Confirm DNS traffic is being generated:

```bash
nslookup google.com
```

3. Ensure firewall is not blocking DNS traffic.

4. Check that DNS queries are not using DoH (DNS over HTTPS).

---

## 🔹 Issue 3: PCAP File Empty

### ❌ Problem:

```
tcpdump -r dns_capture.pcap
```

Shows no output.

### ✅ Solution:

* Make sure traffic was generated during capture.
* Confirm correct filter was used:

```bash
sudo tcpdump -i ens5 -w dns_capture.pcap port 53
```

* Verify capture size:

```bash
ls -lh dns_capture.pcap
```

---

## 🔹 Issue 4: Scapy Import Errors

### ❌ Error:

```
ModuleNotFoundError: No module named 'scapy'
```

### ✅ Solution:

Reinstall scapy:

```bash
pip3 install --upgrade scapy
```

If using virtual environment:

```bash
python3 -m venv venv
source venv/bin/activate
pip install scapy
```

---

## 🔹 Issue 5: DNS Layer Not Detected in Packets

### ❌ Problem:

Script shows zero DNS packets.

### Possible Causes:

* Wrong filter during capture
* DNS over HTTPS (DoH) traffic
* Encrypted DNS (DoT)
* Traffic not actually DNS

### ✅ Solution:

Ensure filter is correct:

```bash
sudo tcpdump -i ens5 port 53
```

Check packet details:

```bash
sudo tcpdump -r dns_capture.pcap -n -v
```

---

## 🔹 Issue 6: Real-Time Monitor Requires Root Privileges

### ❌ Error:

```
PermissionError: [Errno 1] Operation not permitted
```

### ✅ Solution:

Run with sudo:

```bash
sudo python3 dns_monitor.py ens5
```

Packet sniffing requires elevated privileges.

---

## 🔹 Issue 7: DGA Detection Too Sensitive

### ❌ Problem:

Legitimate domains flagged as DGA.

### ✅ Solution:

Adjust detection logic:

Modify threshold in:

```python
if len(sub) > 12 and consonants > vowels * 3:
```

Increase length requirement or ratio multiplier.

Example:

```python
if len(sub) > 15 and consonants > vowels * 4:
```

---

## 🔹 Issue 8: Beaconing Not Detected

### ❌ Problem:

Repeated queries but no beaconing alert.

### Possible Causes:

* Not enough data points
* Irregular time intervals
* Insufficient history window

### ✅ Solution:

Increase history retention window:

```python
timedelta(minutes=10)
```

Or lower detection threshold.

---

## 🔹 Issue 9: Baseline Comparison Not Detecting Anomalies

### ❌ Problem:

No anomalies detected despite suspicious traffic.

### ✅ Checklist:

* Ensure baseline.json exists
* Confirm baseline created from clean traffic
* Verify new PCAP contains additional domains

Recreate baseline if necessary:

```bash
python3 dns_baseline.py --create clean_capture.pcap
```

---

## 🔹 Issue 10: DNS Tunneling Detector Too Strict

### ❌ Problem:

Tunneling not flagged.

### ✅ Adjust Risk Scoring:

Inside dns_tunneling_detector.py:

Lower threshold:

```python
if score >= 2:
```

Instead of:

```python
if score >= 3:
```

Or reduce unique subdomain requirement.

---

## 🔹 Issue 11: Performance Issues During Live Monitoring

### ❌ Problem:

High CPU usage during sniffing.

### ✅ Solutions:

1. Reduce verbosity.
2. Add BPF filters.
3. Limit captured packets:

```python
sniff(count=500, ...)
```

4. Use multiprocessing if scaling.

---

# 📌 Best Practices

* Always validate interface before capture
* Test with controlled DNS queries
* Create clean baseline before anomaly detection
* Tune detection thresholds to reduce false positives
* Store PCAP files securely for forensic integrity
* Document suspicious findings immediately

---

# 🎯 Final Note

DNS traffic analysis depends heavily on:

* Correct packet capture
* Accurate parsing logic
* Proper threshold tuning
* Context-aware anomaly detection

Most issues stem from:

* Wrong interface
* Insufficient traffic
* Detection thresholds too strict or too loose

Systematic troubleshooting ensures accurate DNS forensic analysis.
