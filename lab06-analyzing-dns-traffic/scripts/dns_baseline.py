#!/usr/bin/env python3

import json
import sys
from scapy.all import rdpcap, DNS
from collections import Counter

class DNSBaseline:

    def __init__(self):
        self.baseline = {
            'normal_domains': set(),
            'typical_query_volume': 0,
            'common_query_types': {}
        }

    def create_baseline(self, pcap_file, output_file="baseline.json"):

        packets = rdpcap(pcap_file)

        domains = Counter()
        query_types = Counter()
        total_queries = 0

        for packet in packets:
            if packet.haslayer(DNS):
                dns = packet[DNS]
                if dns.qr == 0 and dns.qd:
                    total_queries += 1
                    domain = dns.qd.qname.decode('utf-8').rstrip('.')
                    domains[domain] += 1
                    query_types[dns.qd.qtype] += 1

        self.baseline['normal_domains'] = list(domains.keys())
        self.baseline['typical_query_volume'] = total_queries
        self.baseline['common_query_types'] = dict(query_types)

        with open(output_file, "w") as f:
            json.dump(self.baseline, f, indent=4)

        print(f"Baseline created and saved to {output_file}")

    def detect_anomalies(self, pcap_file, baseline_file):

        with open(baseline_file, "r") as f:
            baseline = json.load(f)

        baseline_domains = set(baseline['normal_domains'])
        baseline_volume = baseline['typical_query_volume']
        baseline_types = baseline['common_query_types']

        packets = rdpcap(pcap_file)

        current_domains = set()
        current_types = Counter()
        total_queries = 0

        for packet in packets:
            if packet.haslayer(DNS):
                dns = packet[DNS]
                if dns.qr == 0 and dns.qd:
                    total_queries += 1
                    domain = dns.qd.qname.decode('utf-8').rstrip('.')
                    current_domains.add(domain)
                    current_types[dns.qd.qtype] += 1

        anomalies = []

        new_domains = current_domains - baseline_domains
        if new_domains:
            anomalies.append(f"New domains detected: {len(new_domains)}")

        if total_queries > baseline_volume * 1.5:
            anomalies.append("Query volume spike detected")

        for qtype in current_types:
            if str(qtype) not in baseline_types:
                anomalies.append(f"Unusual query type detected: {qtype}")

        return anomalies

def main():

    if len(sys.argv) < 3:
        print("Usage:")
        print("Create baseline: python3 dns_baseline.py --create baseline.pcap")
        print("Detect anomalies: python3 dns_baseline.py --detect traffic.pcap baseline.json")
        sys.exit(1)

    db = DNSBaseline()

    if sys.argv[1] == "--create":
        db.create_baseline(sys.argv[2])

    elif sys.argv[1] == "--detect":
        anomalies = db.detect_anomalies(sys.argv[2], sys.argv[3])
        if anomalies:
            print("\n⚠ Anomalies Detected:")
            for a in anomalies:
                print("-", a)
        else:
            print("No anomalies detected.")

if __name__ == "__main__":
    main()
