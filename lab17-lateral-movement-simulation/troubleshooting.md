# 🛠 Troubleshooting Guide - Lab 17: Lateral Movement and Pivoting (Safe Simulation Version)

---

## 1️⃣ Simulated C2 Server Won’t Start

### Possible Causes:
- Port 8080 already in use
- Python process stuck in background
- Incorrect script permissions
- Firewall blocking port

### Diagnosis:

Check if port is in use:
```

sudo netstat -tulpn | grep :8080

```

Example:
```

tcp   0   0 0.0.0.0:8080   LISTEN   15520/python3

```

Check running processes:
```

ps aux | grep simulated_c2

```

### Solution:

Kill existing process:
```

sudo pkill -f simulated_c2.py

```

Restart server:
```

cd ~/lab17-simulation/c2
python3 simulated_c2.py

```

If necessary, change port inside script.

---

## 2️⃣ Beacon Agent Not Connecting to C2

### Symptoms:
- “Connection failed” message
- No entries in c2_activity.log
- curl test fails

### Diagnosis:

Verify C2 server:
```

curl [http://localhost:8080](http://localhost:8080)

```

Expected:
```

{"status":"ok","command":"none","timestamp":"..."}

```

Check if requests module is installed:
```

pip3 list | grep requests

```

Check firewall:
```

sudo ufw status

```

Check log file:
```

cat logs/c2_activity.log

```

### Solution:

Reinstall requests:
```

pip3 install requests

```

Ensure C2 running in separate terminal.

Verify URL inside agent:
```

C2_URL = "[http://localhost:8080](http://localhost:8080)"

```

---

## 3️⃣ SSH Lateral Movement Fails

### Symptoms:
- Permission denied
- Authentication failure
- Connection refused

### Diagnosis:

Check SSH status:
```

sudo systemctl status ssh

```

Verify user exists:
```

cat /etc/passwd | grep pivotuser

```

Check SSH config:
```

sudo nano /etc/ssh/sshd_config

```

Ensure:
```

PasswordAuthentication yes

```

### Solution:

Reset password:
```

sudo passwd pivotuser

```

Restart SSH:
```

sudo systemctl restart ssh

```

---

## 4️⃣ SSH Port Forwarding Not Working

### Symptoms:
- curl http://localhost:9090 fails
- Connection refused
- No response

### Diagnosis:

Check forwarding command:
```

ssh -L 9090:localhost:8080 pivotuser@localhost

```

Verify 8080 listening:
```

netstat -tulpn | grep 8080

```

Test direct access:
```

curl [http://localhost:8080](http://localhost:8080)

```

### Solution:

Re-run SSH forwarding.

Ensure:

- C2 server running
- SSH session remains active
- No firewall blocking local traffic

---

## 5️⃣ tcpdump Not Showing Traffic

### Symptoms:
- No output displayed
- Empty capture

### Diagnosis:

Confirm correct interface:
```

ip a

```

Use loopback interface for local traffic:
```

sudo tcpdump -i lo -A port 8080

```

### Solution:

Ensure beacon agent running before capturing.

Run tcpdump first, then start beacon.

---

## 6️⃣ Persistence Not Triggering

### Symptoms:
- Beacon not running after new shell
- No process found

### Diagnosis:

Check .bashrc:
```

cat ~/.bashrc | grep beacon_agent

```

Reload shell:
```

source ~/.bashrc

```

Check process:
```

ps aux | grep beacon_agent

```

### Solution:

Re-run persistence script:
```

bash scripts/persistence_sim.sh

```

Ensure correct path inside script.

---

## 7️⃣ Detection Script Shows Nothing

### Symptoms:
- No beacon process shown
- No SSH sessions displayed

### Diagnosis:

Check if beacon is running:
```

ps aux | grep beacon_agent

```

Check listening ports:
```

netstat -tulpn

```

Check active sessions:
```

who

```

### Solution:

Restart beacon agent.

Reconnect SSH session.

---

## 8️⃣ Permission Denied Errors

### Symptoms:
- Script not executable
- Access denied writing files

### Solution:

Make scripts executable:
```

chmod +x script_name.sh

```

Use sudo for system operations:
```

sudo command

```

Verify ownership:
```

ls -la

```

---

## 9️⃣ Log File Not Updating

### Diagnosis:

Check file path inside C2 script:
```

LOG_FILE = "../logs/c2_activity.log"

```

Verify directory exists:
```

ls logs/

```

### Solution:

Create logs directory if missing:
```

mkdir -p ~/lab17-simulation/logs

```

Restart C2 server.

---

## 🔟 High CPU Usage

### Cause:
Beacon interval too low.

### Solution:

Increase jitter interval:
```

time.sleep(random.randint(15, 45))

```

---

# 🔐 Security Considerations

Even though this lab is simulated:

- Real C2 traffic is encrypted
- Real pivoting often uses reverse tunnels
- Real malware implements advanced evasion
- Real environments use EDR and SIEM

Always test only in authorized environments.

---

# 🧹 Cleanup Procedure

After completing lab:

```

pkill -f beacon_agent.py
pkill -f simulated_c2.py
rm -rf ~/lab17-simulation

```

Verify no residual processes:
```

ps aux | grep python

```

---

# 🏁 Final Notes

Most lab failures are caused by:

- Port conflicts
- Missing Python modules
- SSH misconfiguration
- Wrong file paths
- Permission issues

Systematic troubleshooting resolves nearly all issues.
