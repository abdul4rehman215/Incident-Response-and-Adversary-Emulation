#!/usr/bin/env python3

import json
import sys
from datetime import datetime
from collections import defaultdict, Counter

def parse_suricata_logs(log_file):
    """Parse Suricata eve.json log file and generate comprehensive report"""

    alerts = []
    stats = defaultdict(int)

    try:
        with open(log_file, 'r') as f:
            for line in f:
                try:
                    event = json.loads(line.strip())
                    if event.get('event_type') == 'alert':
                        alerts.append(event)
                        stats['total_alerts'] += 1
                except json.JSONDecodeError:
                    continue
    except FileNotFoundError:
        print(f"Error: Log file {log_file} not found")
        return

    if not alerts:
        print("No alerts found in log file")
        return

    print("=" * 60)
    print("SURICATA LOG ANALYSIS REPORT")
    print("=" * 60)
    print(f"Analysis Date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"Total Alerts: {len(alerts)}")
    print()

    signatures = Counter(alert['alert']['signature'] for alert in alerts)
    print("TOP ALERT SIGNATURES:")
    print("-" * 40)
    for sig, count in signatures.most_common(10):
        print(f"{count:4d} | {sig}")
    print()

    src_ips = Counter(alert['src_ip'] for alert in alerts)
    print("TOP SOURCE IPs:")
    print("-" * 40)
    for ip, count in src_ips.most_common(10):
        print(f"{count:4d} | {ip}")
    print()

    dest_ports = Counter(alert.get('dest_port', 'N/A') for alert in alerts)
    print("TOP DESTINATION PORTS:")
    print("-" * 40)
    for port, count in dest_ports.most_common(10):
        print(f"{count:4d} | {port}")
    print()

    severities = Counter(alert['alert']['severity'] for alert in alerts)
    print("SEVERITY DISTRIBUTION:")
    print("-" * 40)
    for severity, count in sorted(severities.items()):
        severity_name = {1: 'High', 2: 'Medium', 3: 'Low'}.get(severity, 'Unknown')
        print(f"{count:4d} | Severity {severity} ({severity_name})")
    print()

    print("ALERT TIMELINE (Last 10 alerts):")
    print("-" * 40)
    recent_alerts = sorted(alerts, key=lambda x: x['timestamp'])[-10:]
    for alert in recent_alerts:
        timestamp = alert['timestamp'][:19]
        signature = alert['alert']['signature'][:50]
        src_ip = alert['src_ip']
        print(f"{timestamp} | {src_ip} | {signature}")

if __name__ == "__main__":
    log_file = "/var/log/suricata/eve.json"
    parse_suricata_logs(log_file)
