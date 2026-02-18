#!/usr/bin/env python3

import json
import time
from playbooks.malware_playbook import MalwarePlaybook
from playbooks.phishing_playbook import PhishingPlaybook


class SIEMIntegration:

    def __init__(self):
        self.malware_playbook = MalwarePlaybook()
        self.phishing_playbook = PhishingPlaybook()

    def process_alert(self, alert):

        alert_type = alert.get("type")
        severity = alert.get("severity")
        data = alert.get("data")

        print(f"[+] Processing {alert_type} alert with severity {severity}")

        if alert_type == "malware":
            incident = {
                "title": "SIEM Malware Alert",
                "description": f"Detected on host {data.get('host')}",
                "severity": severity,
                "affected_hosts": [data.get("host")],
                "observables": [
                    {"type": "hash", "value": data.get("file_hash"), "tags": ["siem_alert"]},
                    {"type": "ip", "value": data.get("host"), "tags": ["endpoint"]}
                ]
            }
            return self.malware_playbook.execute_playbook(incident)

        elif alert_type == "phishing":
            incident = {
                "subject": data.get("subject"),
                "sender": data.get("sender"),
                "recipients": data.get("recipients", []),
                "body": f"Email from {data.get('sender')} with subject {data.get('subject')}",
                "headers": {
                    "received-spf": "fail",
                    "dkim-signature": "",
                    "authentication-results": "dmarc=fail"
                }
            }
            return self.phishing_playbook.execute_playbook(incident)

        else:
            return {"error": "Unknown alert type"}

    def monitor_alerts(self, alert_queue):

        for alert in alert_queue:
            try:
                result = self.process_alert(alert)
                print(json.dumps(result, indent=4))
                print("--------------------------------------------------")
                time.sleep(1)
            except Exception as e:
                print(f"[!] Error processing alert: {e}")


if __name__ == "__main__":

    integration = SIEMIntegration()

    alerts = [
        {
            "type": "malware",
            "severity": "high",
            "source": "endpoint_protection",
            "data": {
                "host": "192.168.1.100",
                "file_hash": "abc123def456",
                "detection_time": "2024-01-15T10:30:00Z"
            }
        },
        {
            "type": "phishing",
            "severity": "medium",
            "source": "email_gateway",
            "data": {
                "sender": "attacker@evil.com",
                "subject": "Urgent Action Required",
                "recipients": ["user@company.com"]
            }
        }
    ]

    integration.monitor_alerts(alerts)
