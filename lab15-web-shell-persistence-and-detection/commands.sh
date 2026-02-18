#!/bin/bash

# ===============================
# Lab 15 – Web Shell Persistence and Detection
# Commands Executed
# Environment: Ubuntu 24.04.1 LTS
# User: toor
# ===============================


# ------------------------------------------------
# Environment Verification
# ------------------------------------------------

cat /etc/os-release
pwd


# ------------------------------------------------
# Task 1 – Apache Setup
# ------------------------------------------------

sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl status apache2

sudo mkdir -p /var/www/html/testapp
sudo chown -R www-data:www-data /var/www/html/testapp
sudo chmod 755 /var/www/html/testapp

ls -ld /var/www/html/testapp


# ------------------------------------------------
# Create Vulnerable Application
# ------------------------------------------------

sudo nano /var/www/html/testapp/index.php
ls -la /var/www/html/testapp


# ------------------------------------------------
# Create Legitimate Pages
# ------------------------------------------------

sudo nano /var/www/html/testapp/about.php
sudo nano /var/www/html/testapp/contact.php

sudo chown -R www-data:www-data /var/www/html/testapp
sudo chmod 644 /var/www/html/testapp/*.php

ls -la /var/www/html/testapp


# ------------------------------------------------
# Task 2 – Web Shell Creation
# ------------------------------------------------

sudo nano /var/www/html/testapp/shell_basic.php
sudo nano /var/www/html/testapp/shell_advanced.php
sudo nano /var/www/html/testapp/config.php

sudo mkdir -p /var/www/html/testapp/uploads
sudo mkdir -p /var/www/html/testapp/.hidden

sudo cp /var/www/html/testapp/shell_basic.php /var/www/html/testapp/uploads/image.php
sudo cp /var/www/html/testapp/shell_advanced.php /var/www/html/testapp/.hidden/admin.php

sudo chown -R www-data:www-data /var/www/html/testapp

ls -la /var/www/html/testapp/uploads
ls -la /var/www/html/testapp/.hidden


# ------------------------------------------------
# Task 3 – Testing Web Shell
# ------------------------------------------------

curl "http://localhost/testapp/shell_basic.php?cmd=whoami"
curl "http://localhost/testapp/shell_basic.php?cmd=pwd"
curl "http://localhost/testapp/shell_basic.php?cmd=id"
curl "http://localhost/testapp/shell_basic.php?cmd=ls"

curl "http://localhost/testapp/uploads/image.php?cmd=uname"

curl -X POST -d "x=phpinfo();" http://localhost/testapp/config.php

sudo tail -5 /var/log/apache2/access.log


# ------------------------------------------------
# Task 4 – Detection Scripts
# ------------------------------------------------

nano ~/webshell_detector.sh
chmod +x ~/webshell_detector.sh
./webshell_detector.sh

nano ~/log_analyzer.sh
chmod +x ~/log_analyzer.sh
./log_analyzer.sh


# ------------------------------------------------
# Install inotify Tools
# ------------------------------------------------

sudo apt install -y inotify-tools

nano ~/realtime_monitor.sh
chmod +x ~/realtime_monitor.sh
./realtime_monitor.sh


# ------------------------------------------------
# Task 5 – Removal & Remediation
# ------------------------------------------------

nano ~/webshell_remover.sh
chmod +x ~/webshell_remover.sh
./webshell_remover.sh

nano ~/verify_cleanup.sh
chmod +x ~/verify_cleanup.sh
./verify_cleanup.sh


# ------------------------------------------------
# Task 6 – Monitoring Dashboard
# ------------------------------------------------

nano ~/webshell_dashboard.sh
chmod +x ~/webshell_dashboard.sh
./webshell_dashboard.sh
