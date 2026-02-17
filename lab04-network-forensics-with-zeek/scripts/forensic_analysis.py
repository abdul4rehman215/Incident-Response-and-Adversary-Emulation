#!/usr/bin/env python3
"""
Zeek Log Forensic Analysis Tool
Analyzes Zeek logs to identify security incidents and generate reports
"""

import json
import os
from collections import Counter
from datetime import datetime


class ZeekForensicAnalyzer:

    def __init__(self):
        self.alerts = []

    def load_malicious_activity_log(self, filename):
        """Load malicious activity alerts"""
        if not os.path.exists(filename):
            print(f"Warning: {filename} not found")
            return

        with open(filename, 'r') as f:
            for line in f:
                parts = line.strip().split(',')
                if len(parts) >= 3:
                    self.alerts.append({
                        'timestamp': parts[0],
                        'source_ip': parts[1],
                        'alert_type': parts[2],
                        'details': ','.join(parts[3:]) if len(parts) > 3 else ''
                    })

    def analyze_connections(self, filename):
        """Analyze connection patterns"""
        if not os.path.exists(filename):
            print(f"Warning: {filename} not found")
            return None

        stats = {
            'total_connections': 0,
            'unique_sources': set(),
            'unique_destinations': set(),
            'protocols': Counter(),
            'top_talkers': Counter()
        }

        with open(filename, 'r') as f:
            for line in f:
                line = line.strip()
                if line.startswith('{'):
                    try:
                        conn = json.loads(line)

                        stats['total_connections'] += 1
                        stats['unique_sources'].add(conn.get('id.orig_h', ''))
                        stats['unique_destinations'].add(conn.get('id.resp_h', ''))
                        stats['protocols'][conn.get('proto', 'unknown')] += 1
                        stats['top_talkers'][conn.get('id.orig_h', '')] += 1

                    except json.JSONDecodeError:
                        continue

        return stats

    def generate_report(self):
        print("=" * 60)
        print("ZEEK FORENSIC ANALYSIS REPORT")
        print("=" * 60)
        print(f"Report Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print()

        print("SECURITY ALERTS SUMMARY")
        print("-" * 30)

        if self.alerts:
            alert_types = Counter([alert['alert_type'] for alert in self.alerts])
            for alert_type, count in alert_types.most_common():
                print(f"{alert_type}: {count}")

            print("\nDETAILED ALERTS:")
            for alert in self.alerts[-10:]:
                print(f"{alert['timestamp']} - {alert['source_ip']} - {alert['alert_type']}")
                if alert['details']:
                    print(f"   Details: {alert['details']}")
        else:
            print("No security alerts detected.")

        print()

        conn_stats = self.analyze_connections('conn.log')

        if conn_stats:
            print("CONNECTION ANALYSIS")
            print("-" * 20)
            print(f"Total Connections: {conn_stats['total_connections']}")
            print(f"Unique Source IPs: {len(conn_stats['unique_sources'])}")
            print(f"Unique Destination IPs: {len(conn_stats['unique_destinations'])}")

            print("\nTop Protocols:")
            for proto, count in conn_stats['protocols'].most_common(5):
                print(f"  {proto}: {count}")

            print("\nTop Talkers:")
            for ip, count in conn_stats['top_talkers'].most_common(5):
                print(f"  {ip}: {count} connections")

        print()
        print("SECURITY RECOMMENDATIONS")
        print("-" * 25)

        if self.alerts:
            print("1. Investigate flagged IP addresses")
            print("2. Review DNS queries to suspicious domains")
            print("3. Analyze suspicious user agents")
            print("4. Monitor for repeated port scanning")
        else:
            print("1. Continue baseline monitoring")
            print("2. Update detection signatures regularly")

        print("\n" + "=" * 60)


def main():
    analyzer = ZeekForensicAnalyzer()
    analyzer.load_malicious_activity_log('malicious_activity.log')
    analyzer.generate_report()


if __name__ == "__main__":
    main()
