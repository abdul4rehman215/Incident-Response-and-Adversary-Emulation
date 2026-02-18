# 🛠 Troubleshooting Guide - Lab 19: Incident Recovery Playbooks with SOAR

---

## 1️⃣ Docker Containers Not Starting

### Symptoms
- Containers exit immediately
- `docker compose ps` shows "Exited"
- Services not reachable on ports 9000, 9001, 9200

### Diagnosis

Check container status:
```

docker compose ps

```

Check logs:
```

docker compose logs -f

```

Check specific service:
```

docker logs thehive
docker logs cortex
docker logs elasticsearch

```

### Common Causes

- Port already in use
- Incorrect file permissions
- Elasticsearch memory issues
- Invalid configuration syntax

### Solution

Verify ports:
```

netstat -tuln | grep -E '9000|9001|9200'

```

Adjust permissions:
```

sudo chown -R 1000:1000 data/
chmod -R 755 data/

```

Restart services:
```

docker compose down
docker compose up -d

```

---

## 2️⃣ Elasticsearch Not Healthy (Status Not Green)

### Symptoms
- `_cluster/health` shows yellow or red
- TheHive fails to connect

### Diagnosis

Check cluster health:
```

curl [http://localhost:9200/_cluster/health](http://localhost:9200/_cluster/health)

```

Check logs:
```

docker logs elasticsearch

```

### Common Causes

- Insufficient memory
- Corrupted data directory
- Disk full

### Solution

Increase Java heap memory in docker-compose.yml:
```

ES_JAVA_OPTS=-Xms512m -Xmx512m

```

Check disk space:
```

df -h

```

If corrupted:
```

docker compose down
rm -rf data/elasticsearch
docker compose up -d

```

---

## 3️⃣ TheHive API Not Responding

### Symptoms
- `curl http://localhost:9000/api/status` fails
- Browser cannot load TheHive UI

### Diagnosis

Check container:
```

docker compose ps

```

Review logs:
```

docker logs thehive

```

### Common Causes

- Incorrect application.conf
- Cortex service unavailable
- Elasticsearch not ready

### Solution

Ensure proper configuration in:
```

thehive/application.conf

```

Restart stack:
```

docker compose restart

```

Wait at least 2 minutes before retrying.

---

## 4️⃣ Cortex Not Connecting to Elasticsearch

### Symptoms
- Cortex container logs show connection errors
- Playbook analysis fails

### Diagnosis

Check:
```

docker logs cortex

```

Verify Elasticsearch reachable:
```

curl [http://localhost:9200](http://localhost:9200)

```

### Solution

Ensure correct URI in:
```

cortex/application.conf

```
```

uri = "[http://elasticsearch:9200](http://elasticsearch:9200)"

```

Restart Cortex:
```

docker compose restart cortex

```

---

## 5️⃣ Playbook Execution Fails

### Symptoms
- Python errors
- JSON parsing errors
- Missing modules

### Diagnosis

Check syntax:
```

python3 -m py_compile playbooks/malware_playbook.py

```

Validate JSON:
```

cat playbooks/malware_response.json | python3 -m json.tool

```

### Solution

Ensure:
- Correct indentation
- No missing commas
- Python 3.10+ installed

Check Python version:
```

python3 --version

```

---

## 6️⃣ SIEM Integration Script Import Error

### Symptoms
- ModuleNotFoundError
- Cannot import playbooks

### Cause

Python cannot locate playbooks module.

### Solution

Run from project root:
```

cd ~/soar-lab
python3 integration/siem_integration.py

```

Or add project root to PYTHONPATH:
```

export PYTHONPATH=$(pwd)

```

---

## 7️⃣ Port Conflicts

### Symptoms
- “Address already in use” errors

### Diagnosis

Check port usage:
```

sudo netstat -tulpn

```

### Solution

Kill process:
```

sudo kill -9 <PID>

```

Or change ports in docker-compose.yml.

---

## 8️⃣ Docker Permission Issues

### Symptoms
- Permission denied
- Cannot write to data directory

### Solution

Fix ownership:
```

sudo chown -R 1000:1000 data/

```

Verify:
```

ls -la data/

```

---

## 9️⃣ High Resource Usage

### Symptoms
- System slow
- Containers restart

### Cause

Elasticsearch is memory intensive.

### Solution

Lower heap memory:
```

ES_JAVA_OPTS=-Xms256m -Xmx256m

```

Restart services.

---

## 🔟 Data Persistence Issues

### Symptoms
- Cases disappear after restart

### Cause

Data volumes not mounted correctly.

### Solution

Verify volume paths in docker-compose.yml:
```

./data/thehive:/opt/thp/thehive/data

```

Ensure directories exist:
```

ls -la data/

```

---

# 🔐 Security Considerations

Even in lab environments:

- Do not expose ports publicly
- Restrict firewall access
- Rotate secret keys
- Avoid weak secret values
- Monitor logs for abnormal behavior
- Secure Docker daemon

---

# 🧹 Cleanup Procedure

To remove entire SOAR stack:

```

docker compose down
rm -rf ~/soar-lab

```

Verify no containers running:
```

docker ps

```

---

# 🏁 Final Notes

Most common issues are:

- Configuration syntax errors
- Insufficient memory
- Incorrect permissions
- Port conflicts
- Service startup timing issues

Always:

1. Check container status
2. Review logs
3. Verify configuration
4. Restart services carefully

Systematic troubleshooting resolves nearly all deployment issues.
