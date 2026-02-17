#!/usr/bin/env python3

"""
Network Infrastructure Analysis Script
Performs WHOIS lookup on IP addresses.
"""

import subprocess

def analyze_network_range(ip_address):
    try:
        result = subprocess.run(
            ['whois', ip_address],
            capture_output=True,
            text=True
        )

        lines = result.stdout.split('\n')
        network_info = {}

        for line in lines:
            if 'NetRange:' in line or 'inetnum:' in line:
                network_info['range'] = line.split(':', 1)[1].strip()
            elif 'Organization:' in line or 'org-name:' in line:
                network_info['org'] = line.split(':', 1)[1].strip()
            elif 'Country:' in line:
                network_info['country'] = line.split(':', 1)[1].strip()

        return network_info

    except Exception as e:
        print(f"[!] Error analyzing {ip_address}: {e}")
        return {}

def main():
    ips = ['8.8.8.8', '1.1.1.1']

    for ip in ips:
        print(f"\nAnalyzing {ip}:")
        info = analyze_network_range(ip)
        for key, value in info.items():
            print(f" {key}: {value}")

if __name__ == "__main__":
    main()
