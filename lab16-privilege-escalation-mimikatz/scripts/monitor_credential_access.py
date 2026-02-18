#!/usr/bin/env python3
# File: monitor_credential_access.py

import time
import json
import subprocess
from datetime import datetime


class CredentialAccessMonitor:

    def __init__(self):
        self.alerts = []
        self.baseline = {}

    def establish_baseline(self):

        print("[*] Establishing LSASS baseline...")

        cmd = ["pwsh", "-Command", "Get-Process -Name lsass | Select-Object CPU,WS"]
        result = subprocess.run(cmd, capture_output=True, text=True)

        self.baseline["lsass"] = result.stdout
        print("[+] Baseline recorded")

    def monitor_lsass_access(self):

        cmd = ["pwsh", "-Command", "Get-Process -Name lsass | Select-Object CPU,WS"]
        result = subprocess.run(cmd, capture_output=True, text=True)

        if result.stdout != self.baseline.get("lsass"):
            self.generate_alert("LSASS Memory Change", "LSASS memory usage changed unexpectedly")

    def detect_mimikatz_indicators(self):

        cmd = ["pwsh", "-Command", "Get-Process | Where-Object {$_.ProcessName -match 'mimikatz'}"]
        result = subprocess.run(cmd, capture_output=True, text=True)

        if result.stdout.strip():
            self.generate_alert("Mimikatz Detected", "Mimikatz process running")

    def analyze_authentication_logs(self):

        cmd = [
            "pwsh",
            "-Command",
            "Get-WinEvent -LogName Security -MaxEvents 10 | Select-Object Id,TimeCreated"
        ]

        result = subprocess.run(cmd, capture_output=True, text=True)

        if "4625" in result.stdout:
            self.generate_alert("Failed Logon Attempts", "Multiple failed logon events detected")

    def generate_alert(self, alert_type, details):

        alert = {
            "timestamp": datetime.now().isoformat(),
            "type": alert_type,
            "details": details
        }

        self.alerts.append(alert)

        print(f"[ALERT] {alert_type} - {details}")

        with open("security_alerts.json", "w") as f:
            json.dump(self.alerts, f, indent=4)


def main():

    monitor = CredentialAccessMonitor()

    monitor.establish_baseline()

    print("[*] Starting monitoring loop (Ctrl+C to stop)...")

    try:
        while True:
            monitor.monitor_lsass_access()
            monitor.detect_mimikatz_indicators()
            monitor.analyze_authentication_logs()
            time.sleep(10)

    except KeyboardInterrupt:
        print("\nMonitoring stopped.")


if __name__ == "__main__":
    main()
