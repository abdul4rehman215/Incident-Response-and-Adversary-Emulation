#!/usr/bin/env python3

from scapy.all import rdpcap, DNS
import sys
from collections import defaultdict
import statistics

def get_base_domain(domain):
    parts = domain.split('.')
    if len(parts) >= 2:
        return '.'.join(parts[-2:])
    return domain

def detect_dns_tunneling(pcap_file):

    packets = rdpcap(pcap_file)

    domain_metrics = defaultdict(lambda: {
        'query_count': 0,
        'query_lengths': [],
        'unique_subdomains': set(),
        'txt_records': 0
    })

    for packet in packets:
        if packet.haslayer(DNS):
            dns_layer = packet[DNS]

            if dns_layer.qr == 0 and dns_layer.qd:

                domain = dns_layer.qd.qname.decode('utf-8').rstrip('.')
                base = get_base_domain(domain)
                subdomain = domain.replace("." + base, "")

                domain_metrics[base]['query_count'] += 1
                domain_metrics[base]['query_lengths'].append(len(domain))
                domain_metrics[base]['unique_subdomains'].add(subdomain)

                if dns_layer.qd.qtype == 16:
                    domain_metrics[base]['txt_records'] += 1

    tunneling_indicators = []

    for domain, metrics in domain_metrics.items():

        score = 0
        avg_length = statistics.mean(metrics['query_lengths']) if metrics['query_lengths'] else 0

        if metrics['query_count'] > 50:
            score += 1

        if len(metrics['unique_subdomains']) > 20:
            score += 1

        if avg_length > 30:
            score += 1

        if metrics['txt_records'] > 10:
            score += 1

        if score >= 3:
            tunneling_indicators.append({
                "domain": domain,
                "risk_score": score,
                "query_count": metrics['query_count'],
                "unique_subdomains": len(metrics['unique_subdomains']),
                "avg_length": avg_length,
                "txt_records": metrics['txt_records']
            })

    return tunneling_indicators

def main():

    if len(sys.argv) != 2:
        print("Usage: python3 dns_tunneling_detector.py <pcap_file>")
        sys.exit(1)

    results = detect_dns_tunneling(sys.argv[1])

    if results:
        print("\n⚠ Potential DNS Tunneling Detected:\n")
        for r in results:
            print(f"Domain: {r['domain']}")
            print(f"Risk Score: {r['risk_score']}")
            print(f"Queries: {r['query_count']}")
            print(f"Unique Subdomains: {r['unique_subdomains']}")
            print(f"Average Length: {r['avg_length']:.2f}")
            print(f"TXT Records: {r['txt_records']}\n")
    else:
        print("No DNS tunneling indicators detected.")

if __name__ == "__main__":
    main()
