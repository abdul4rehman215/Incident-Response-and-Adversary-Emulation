#!/usr/bin/env python3

import json
import sys
from scapy.all import rdpcap, DNS
from collections import Counter
from datetime import datetime
import re

def is_dga(domain):
    sub = domain.split('.')[0]
    vowels = len(re.findall(r'[aeiou]', sub))
    consonants = len(re.findall(r'[bcdfghjklmnpqrstvwxyz]', sub))

    if len(sub) > 12 and consonants > vowels * 3:
        return True
    return False

def generate_report(pcap_file, output_file="report.json"):

    packets = rdpcap(pcap_file)

    queried_domains = Counter()
    suspicious_activity = []

    for packet in packets:
        if packet.haslayer(DNS):
            dns = packet[DNS]
            if dns.qr == 0 and dns.qd:
                domain = dns.qd.qname.decode('utf-8').rstrip('.')
                queried_domains[domain] += 1

                if is_dga(domain):
                    suspicious_activity.append(
                        f"DGA-like domain detected: {domain}"
                    )

                if any(keyword in domain.lower() for keyword in
                       ['malware', 'phishing', 'trojan', 'botnet']):
                    suspicious_activity.append(
                        f"Suspicious keyword domain: {domain}"
                    )

    report = {
        'timestamp': datetime.now().isoformat(),
        'total_queries': sum(queried_domains.values()),
        'unique_domains': len(queried_domains),
        'top_domains': dict(queried_domains.most_common(10)),
        'suspicious_activity': suspicious_activity,
        'recommendations': []
    }

    if suspicious_activity:
        report['recommendations'].append(
            "Investigate suspicious domains immediately"
        )
        report['recommendations'].append(
            "Check endpoint systems for malware"
        )
        report['recommendations'].append(
            "Block malicious domains at firewall/DNS level"
        )
    else:
        report['recommendations'].append(
            "Continue monitoring DNS traffic"
        )

    with open(output_file, "w") as f:
        json.dump(report, f, indent=4)

    print(f"Report generated: {output_file}")

def main():

    if len(sys.argv) != 2:
        print("Usage: python3 dns_report.py <pcap_file>")
        sys.exit(1)

    generate_report(sys.argv[1])

if __name__ == "__main__":
    main()
