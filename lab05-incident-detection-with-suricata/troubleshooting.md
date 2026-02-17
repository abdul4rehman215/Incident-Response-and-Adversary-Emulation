# 🛠 Troubleshooting Guide - LAB 05: Incident Detection with Suricata

---

# 🔎 Issue 1: Suricata Service Fails to Start

## Symptoms:
- `sudo systemctl status suricata` shows **failed**
- Suricata exits immediately
- Errors in `/var/log/suricata/suricata.log`

## Diagnosis:

```bash
sudo systemctl status suricata
sudo suricata -T -c /etc/suricata/suricata.yaml -v
sudo tail -50 /var/log/suricata/suricata.log
````

## Common Causes:

* Syntax error in `suricata.yaml`
* Incorrect rule file path
* Invalid rule syntax
* Interface misconfiguration

## Resolution:

1. Validate configuration:

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml -v
```

2. Confirm rule paths:

```yaml
rule-files:
  - suricata.rules
  - custom/lab-rules.rules
```

3. Restart service:

```bash
sudo systemctl restart suricata
```

---

# 🔎 Issue 2: No Alerts Generated

## Symptoms:

* Traffic generated but no entries in `fast.log`
* `eve.json` contains events but no alerts

## Diagnosis:

```bash
sudo suricata --list-app-layer-protos
ip addr show
sudo tcpdump -i ens5 -c 10
```

## Possible Causes:

* Wrong network interface configured
* HOME_NET incorrectly defined
* Traffic not reaching monitored interface
* Custom rules not enabled

## Resolution:

1. Confirm active interface:

```bash
ip route | grep default
```

2. Verify `suricata.yaml` AF-PACKET configuration:

```yaml
af-packet:
  - interface: ens5
```

3. Confirm HOME_NET matches local subnet:

```yaml
HOME_NET: "[172.16.0.0/12]"
```

4. Ensure custom rules are included:

```yaml
rule-files:
  - suricata.rules
  - custom/lab-rules.rules
```

---

# 🔎 Issue 3: High CPU Usage

## Symptoms:

* Suricata consuming excessive CPU
* System slowdown

## Diagnosis:

```bash
top -p $(pgrep suricata)
```

## Causes:

* Large rule set
* High traffic volume
* Excessive logging
* Improper thread configuration

## Resolution:

1. Reduce rule sets:

```bash
sudo suricata-update disable-source <rule-set>
```

2. Tune threading in `suricata.yaml`:

```yaml
max-pending-packets: 1024
```

3. Disable unnecessary log types.

4. Restart service:

```bash
sudo systemctl restart suricata
```

---

# 🔎 Issue 4: Log Files Growing Too Large

## Symptoms:

* `/var/log/suricata/eve.json` exceeds several MB/GB
* Disk usage increasing

## Solution: Enable Log Rotation

Edit:

```bash
sudo nano /etc/logrotate.d/suricata
```

Add:

```
/var/log/suricata/*.log {
  daily
  missingok
  rotate 7
  compress
  notifempty
  create 640 root adm
  postrotate
    /bin/kill -HUP $(cat /var/run/suricata.pid 2>/dev/null) 2>/dev/null || true
  endscript
}
```

---

# 🔎 Issue 5: Rule Syntax Errors

## Symptoms:

* Suricata fails config test
* Error mentions specific SID

## Diagnosis:

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml -v
```

## Common Mistakes:

* Missing semicolon
* Incorrect keyword order
* Duplicate SID
* Invalid protocol keyword

## Fix:

* Validate rule formatting
* Ensure SID uniqueness
* Check Suricata rule documentation

---

# 🔎 Issue 6: jq Parsing Errors

## Symptoms:

* `jq` returns error parsing JSON
* Script fails to extract alerts

## Causes:

* Corrupted log line
* Incomplete JSON entry
* Log rotation during read

## Fix:

```bash
sudo cat /var/log/suricata/eve.json | jq -c .
```

If error persists:

* Restart Suricata
* Clear partial logs

---

# 🔎 Issue 7: Suricata Not Capturing Traffic

## Diagnosis:

```bash
sudo tcpdump -i ens5 -c 20
```

If no packets:

* Cloud security group blocking traffic
* Interface not in promiscuous mode
* Running inside restricted VM

Enable promiscuous mode:

```bash
sudo ip link set ens5 promisc on
```

---

# 🔎 Issue 8: Custom Rules Not Triggering

## Checklist:

✔ Rule file included in config
✔ SID not conflicting
✔ Rule syntax valid
✔ Traffic matches rule condition
✔ Suricata restarted

Verify rule loading:

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml -v
```

---

# 📊 Performance Validation Commands

```bash
sudo systemctl status suricata
top -bn1 | grep suricata
sudo tail -20 /var/log/suricata/stats.log
ls -lh /var/log/suricata/
```

---

# 🔐 Incident Response Validation

After detection:

1. Extract alerts:

```bash
jq 'select(.event_type=="alert")' eve.json
```

2. Identify source IPs:

```bash
jq -r 'select(.event_type=="alert") | .src_ip' eve.json | sort | uniq
```

3. Correlate timeline:

```bash
jq -r '"\(.timestamp) \(.alert.signature)"' eve.json
```

---

# 🎯 Final Validation Checklist

✔ Suricata service running
✔ Rules loaded successfully
✔ Alerts generated
✔ Logs rotating properly
✔ CPU and memory stable
✔ Incident response scripts operational

---

# 🏁 Conclusion

This troubleshooting guide ensures:

* Reliable Suricata deployment
* Proper alert generation
* Stable system performance
* Effective rule validation
* Professional SOC-grade monitoring

These troubleshooting methodologies mirror real-world Security Operations Center workflows.
