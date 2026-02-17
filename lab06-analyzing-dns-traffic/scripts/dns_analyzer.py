#!/usr/bin/env python3

import sys
from scapy.all import rdpcap, DNS
from collections import Counter
import re

def analyze_dns_traffic(pcap_file):

    packets = rdpcap(pcap_file)

    total_queries = 0
    total_responses = 0
    queried_domains = Counter()
    query_types = Counter()
    response_codes = Counter()

    for packet in packets:
        if packet.haslayer(DNS):
            dns_layer = packet[DNS]

            if dns_layer.qr == 0:
                total_queries += 1
                if dns_layer.qd:
                    domain = dns_layer.qd.qname.decode('utf-8').rstrip('.')
                    queried_domains[domain] += 1
                    query_types[dns_layer.qd.qtype] += 1

            elif dns_layer.qr == 1:
                total_responses += 1
                response_codes[dns_layer.rcode] += 1

    return {
        "total_queries": total_queries,
        "total_responses": total_responses,
        "queried_domains": queried_domains,
        "query_types": query_types,
        "response_codes": response_codes
    }

def is_dga_like(domain):
    sub = domain.split('.')[0]

    vowels = len(re.findall(r'[aeiou]', sub))
    consonants = len(re.findall(r'[bcdfghjklmnpqrstvwxyz]', sub))

    if len(sub) > 12 and consonants > vowels * 3:
        return True
    return False

def detect_suspicious_patterns(queried_domains):

    suspicious_indicators = []

    for domain, count in queried_domains.items():

        if count > 10:
            suspicious_indicators.append(
                f"High-frequency domain: {domain} ({count} queries)"
            )

        if any(keyword in domain.lower() for keyword in
               ['malware', 'phishing', 'trojan', 'botnet']):
            suspicious_indicators.append(
                f"Suspicious keyword in domain: {domain}"
            )

        if is_dga_like(domain):
            suspicious_indicators.append(
                f"DGA-like domain detected: {domain}"
            )

    return suspicious_indicators

def main():

    if len(sys.argv) != 2:
        print("Usage: python3 dns_analyzer.py <pcap_file>")
        sys.exit(1)

    pcap_file = sys.argv[1]

    results = analyze_dns_traffic(pcap_file)

    print("\n=== DNS Traffic Analysis ===")
    print(f"Total Queries: {results['total_queries']}")
    print(f"Total Responses: {results['total_responses']}")
    print(f"Unique Domains: {len(results['queried_domains'])}")

    print("\nTop 10 Queried Domains:")
    for domain, count in results['queried_domains'].most_common(10):
        print(f"{domain}: {count}")

    suspicious = detect_suspicious_patterns(results['queried_domains'])

    if suspicious:
        print("\n⚠ Suspicious Activity Detected:")
        for indicator in suspicious:
            print(f"- {indicator}")
    else:
        print("\nNo obvious suspicious activity detected.")

if __name__ == "__main__":
    main()
