#!/bin/bash
# Lab 19 – Incident Recovery Playbooks with SOAR
# All commands executed during the lab

############################################
# Task 1 – Deploy SOAR Platform
############################################

# Create project structure
mkdir -p ~/soar-lab/{thehive,cortex,data,playbooks,integration}
cd ~/soar-lab

# Verify structure
ls -la

############################################
# Create Docker Compose configuration
############################################

nano docker-compose.yml

# Validate YAML
docker compose config

############################################
# Configure TheHive
############################################

nano thehive/application.conf

############################################
# Configure Cortex
############################################

nano cortex/application.conf

############################################
# Set permissions for data directory
############################################

sudo chown -R 1000:1000 data/
chmod -R 755 data/

############################################
# Launch SOAR stack
############################################

docker compose up -d

# Wait for initialization
sleep 120

# Verify containers running
docker compose ps

############################################
# Verify Elasticsearch health
############################################

curl http://localhost:9200/_cluster/health

############################################
# Verify TheHive API
############################################

curl http://localhost:9000/api/status

############################################
# Task 2 – Malware Response Playbook
############################################

# Create malware playbook JSON definition
nano playbooks/malware_response.json

# Create malware playbook Python script
nano playbooks/malware_playbook.py

# Make executable
chmod +x playbooks/malware_playbook.py

# Execute malware playbook
python3 playbooks/malware_playbook.py

############################################
# Task 3 – Phishing Response Playbook
############################################

# Create phishing playbook
nano playbooks/phishing_playbook.py

# Verify playbook directory
ls -la playbooks/

# Make executable
chmod +x playbooks/phishing_playbook.py

# Execute phishing playbook
python3 playbooks/phishing_playbook.py

############################################
# Task 4 – SIEM Integration
############################################

# Create SIEM integration script
nano integration/siem_integration.py

# Verify directory structure
tree .

# Make executable
chmod +x integration/siem_integration.py

# Execute SIEM integration simulation
python3 integration/siem_integration.py

############################################
# Verification Checks
############################################

# Confirm containers running
docker compose ps

# Verify ports listening
netstat -tuln | grep -E '9000|9001|9200'

############################################
# Optional Debugging Commands
############################################

# View Docker logs
docker compose logs -f

# Check specific container logs
docker logs thehive
docker logs cortex
docker logs elasticsearch

# Check disk space
df -h

# Stop stack (if needed)
docker compose down

############################################
# End of Lab 19 Commands
############################################
