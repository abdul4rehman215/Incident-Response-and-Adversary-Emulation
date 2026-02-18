# 🛠 Troubleshooting Guide - Lab 20: Final Incident Response Simulation

---

# 1️⃣ Wazuh Issues

## Issue: Wazuh Manager Not Starting

### Symptoms
- `sudo systemctl status wazuh-manager` shows failed
- Service exits immediately

### Diagnosis
```

sudo systemctl status wazuh-manager
sudo journalctl -u wazuh-manager -f

```

### Common Causes
- Configuration syntax errors in ossec.conf
- Permission issues
- Corrupted log files
- Insufficient memory

### Fix
```

sudo /var/ossec/bin/ossec-control restart
sudo chown -R ossec:ossec /var/ossec
sudo chmod -R 750 /var/ossec

```

Validate config:
```

sudo /var/ossec/bin/ossec-logtest

```

---

## Issue: No Alerts Being Generated

### Symptoms
- alerts.log not updating
- No detection events

### Diagnosis
```

sudo tail -f /var/ossec/logs/alerts/alerts.log

```

### Fix
Verify log permissions:
```

sudo chmod 644 /var/log/suricata/eve.json
sudo chown ossec:ossec /var/log/suricata/eve.json

```

Restart:
```

sudo systemctl restart wazuh-manager

```

---

# 2️⃣ Suricata Issues

## Issue: Suricata Not Detecting Traffic

### Diagnosis
```

sudo systemctl status suricata
sudo tail -f /var/log/suricata/fast.log

```

### Common Causes
- Incorrect interface
- Rules not loaded
- JSON output disabled

### Fix

Verify interface:
```

ip link show

```

Update config:
```

sudo sed -i "s/interface: eth0/interface: ens5/" /etc/suricata/suricata.yaml

```

Update rules:
```

sudo suricata-update

```

Restart:
```

sudo systemctl restart suricata

```

---

## Issue: Suricata Permission Errors

Fix:
```

sudo chown -R suricata:suricata /var/log/suricata
sudo chmod -R 755 /var/log/suricata

```

---

# 3️⃣ Zeek Issues

## Issue: Zeek Not Starting

### Diagnosis
```

sudo /opt/zeek/bin/zeekctl status

```

Check logs:
```

sudo cat /opt/zeek/logs/current/stderr.log

```

### Fix

Reinstall:
```

sudo /opt/zeek/bin/zeekctl install
sudo /opt/zeek/bin/zeekctl deploy

```

Restart:
```

sudo /opt/zeek/bin/zeekctl restart

```

---

## Issue: Zeek Interface Binding Error

Check available interfaces:
```

ip route | grep default

```

Update node.cfg accordingly.

---

# 4️⃣ Log Integration Problems

## Issue: Wazuh Not Reading Suricata or Zeek Logs

### Diagnosis
Check ossec.conf entries:
```

sudo nano /var/ossec/etc/ossec.conf

```

Verify:
```

<location>/var/log/suricata/eve.json</location>

```

Restart:
```

sudo systemctl restart wazuh-manager

```

---

# 5️⃣ Firewall Issues

## Issue: Network Block Rules Not Working

Check rules:
```

sudo iptables -L -n

```

If missing:
```

sudo iptables -A INPUT -s 192.168.1.100 -j DROP

```

Persist rules (optional):
```

sudo apt install iptables-persistent

```

---

# 6️⃣ Immutable Attribute Lock Issue

If system login breaks due to:

```

chattr +i /etc/passwd
chattr +i /etc/shadow

```

Fix:
```

sudo chattr -i /etc/passwd
sudo chattr -i /etc/shadow

```

⚠ Always remove immutable flag before system modifications.

---

# 7️⃣ ClamAV Issues

## Issue: freshclam Fails

Fix:
```

sudo systemctl stop clamav-freshclam
sudo freshclam
sudo systemctl start clamav-freshclam

```

---

# 8️⃣ Evidence Collection Errors

## Issue: Permission Denied During Log Copy

Fix:
```

sudo chown -R toor:toor ~/incident-response-lab

```

---

# 9️⃣ Apache Hardening Errors

If security.conf not found:
```

ls /etc/apache2/conf-available/

```

Ensure Apache installed:
```

sudo apt install apache2

```

---

# 🔟 Documentation Compilation Errors

## Issue: Copy Fails

Ensure directories exist:
```

mkdir -p ~/incident-response-lab/final_documentation

```

Verify disk space:
```

df -h

```

---

# 1️⃣1️⃣ High CPU or Memory Usage

Elasticsearch or Suricata may consume high memory.

Check:
```

htop

```

Adjust Suricata threads in:
```

/etc/suricata/suricata.yaml

```

---

# 1️⃣2️⃣ Logs Not Updating

Check file growth:
```

sudo watch -n 2 wc -l /var/log/suricata/fast.log

```

If static:
- Verify tool running
- Check permissions
- Confirm correct interface

---

# 🧹 Cleanup Procedure

To reset lab environment:

```

sudo systemctl stop wazuh-manager
sudo systemctl stop suricata
sudo /opt/zeek/bin/zeekctl stop

sudo iptables -F
sudo chattr -i /etc/passwd
sudo chattr -i /etc/shadow

rm -rf ~/incident-response-lab

```

---

# 🏁 Final Notes

Most common issues in SOC deployments:

- Incorrect interface configuration
- Log permission errors
- Service startup order problems
- Firewall misconfiguration
- Insufficient memory

Always troubleshoot in this order:

1. Check service status
2. Review logs
3. Validate configuration
4. Restart services
5. Confirm detection output

Systematic troubleshooting resolves nearly all issues.

---

# ✅ Lab 20 Complete

You have now completed:

- SOC deployment
- Multi-vector detection
- Incident response lifecycle
- Containment & eradication
- Recovery validation
- Professional documentation
- Troubleshooting readiness

This lab demonstrates full blue-team operational capability.
