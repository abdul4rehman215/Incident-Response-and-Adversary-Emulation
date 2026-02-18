# 🛠 Troubleshooting Guide - Lab 18: C2 Evasion Techniques (Safe Simulation Version)

---

## 1️⃣ Simulated C2 Server Won’t Start

### Symptoms:
- Port 8080 already in use
- “Address already in use” error
- Server immediately exits

### Diagnosis:

Check if port 8080 is occupied:
```

sudo netstat -tulpn | grep :8080

```

Check running Python processes:
```

ps aux | grep c2_server

```

### Solution:

Kill existing process:
```

sudo pkill -f c2_server.py

```

Restart server:
```

cd ~/c2-simulation/server
python3 c2_server.py

```

If necessary, change port in `c2_server.py`.

---

## 2️⃣ Beacon Implant Not Connecting

### Symptoms:
- “Connection failed” errors
- No logs in c2_server.log
- curl test fails

### Diagnosis:

Test server manually:
```

curl [http://localhost:8080](http://localhost:8080)

```

Expected:
```

{"status":"ok","command":"none","timestamp":"..."}

```

Check if `requests` is installed:
```

pip3 list | grep requests

```

Check firewall:
```

sudo ufw status

```

### Solution:

Reinstall requests:
```

pip3 install requests

```

Ensure server is running before implant.

Verify C2 URL inside beacon.py:
```

C2_URL = "[http://localhost:8080](http://localhost:8080)"

```

---

## 3️⃣ Anti-Analysis Check Causes Immediate Exit

### Symptoms:
- Beacon exits immediately
- “Analysis tool detected” message

### Diagnosis:

Check if debugging tools exist:
```

ls /usr/bin/strace
ls /usr/bin/gdb

```

### Solution:

Temporarily comment out anti-analysis function in `beacon.py` for testing:

```

# anti_analysis_checks()

```

Restart beacon after modification.

---

## 4️⃣ Persistence Not Working

### Symptoms:
- Beacon not starting after login
- No background process found

### Diagnosis:

Check .bashrc:
```

cat ~/.bashrc | grep beacon.py

```

Reload shell:
```

source ~/.bashrc

```

Verify running process:
```

ps aux | grep beacon.py

```

### Solution:

Ensure correct path in persistence.sh:
```

nohup python3 ~/c2-simulation/implant/beacon.py &

```

Make script executable:
```

chmod +x scripts/persistence.sh

```

Re-run persistence script.

---

## 5️⃣ No Traffic Visible in tcpdump

### Symptoms:
- No captured packets
- Blank tcpdump screen

### Diagnosis:

Check interface:
```

ip link show

```

Use loopback interface for local traffic:
```

sudo tcpdump -i lo -A port 8080

```

### Solution:

Start tcpdump first, then run beacon.

Ensure both server and beacon are active.

---

## 6️⃣ Domain Fronting Simulation Not Working

### Symptoms:
- curl returns connection refused
- No response from server

### Diagnosis:

Test server directly:
```

curl [http://localhost:8080](http://localhost:8080)

```

Check if server running:
```

netstat -tulpn | grep 8080

```

Verify script contents:
```

cat scripts/domain_fronting.sh

```

### Solution:

Restart C2 server.

Ensure correct Host header syntax:
```

curl -H "Host: [www.google.com](http://www.google.com)" [http://localhost:8080](http://localhost:8080)

```

---

## 7️⃣ Detection Script Shows Nothing

### Symptoms:
- No beacon process detected
- No open port detected

### Diagnosis:

Check process:
```

ps aux | grep beacon.py

```

Check listening port:
```

netstat -tulpn

```

### Solution:

Restart beacon.

Restart C2 server.

Ensure both are running simultaneously.

---

## 8️⃣ Permission Denied Errors

### Symptoms:
- Script not executable
- Cannot write to log file

### Solution:

Make executable:
```

chmod +x script_name.sh

```

Check directory permissions:
```

ls -la

```

Use sudo only when required.

---

## 9️⃣ Log File Not Updating

### Diagnosis:

Check log file path in server script:
```

LOG_FILE = "../logs/c2_server.log"

```

Ensure logs directory exists:
```

ls logs/

```

### Solution:

Create logs directory if missing:
```

mkdir -p ~/c2-simulation/logs

```

Restart server.

---

## 🔟 High CPU Usage

### Cause:
Beacon interval too short.

### Solution:

Increase jitter interval:
```

sleep_time = random.randint(15, 45)

```

Restart beacon.

---

# 🔐 Security Considerations

Even though this lab is simulated:

- Real C2 traffic is often encrypted
- Real implants use HTTPS/TLS
- Real attackers use domain fronting over CDNs
- Real environments deploy EDR detection
- Real malware uses advanced evasion techniques

This simulation demonstrates concepts only.

---

# 🧹 Cleanup Procedure

After completing lab:

```

pkill -f beacon.py
pkill -f c2_server.py
rm -rf ~/c2-simulation

```

Verify no residual processes:
```

ps aux | grep python

```

---

# 🏁 Final Notes

Most common issues:

- Port conflicts
- Missing Python modules
- Incorrect file paths
- Permissions
- Firewall restrictions

Systematic troubleshooting resolves nearly all lab issues.

When ready, send **Lab 19** and we continue in the same structured professional format.
