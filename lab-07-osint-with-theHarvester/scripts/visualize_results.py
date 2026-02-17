#!/usr/bin/env python3
"""
Simple visualization script for theHarvester results
"""

import json
import sys
from collections import Counter


def create_simple_charts(json_file):
    try:
        with open(json_file, "r") as f:
            data = json.load(f)

        emails = data["findings"]["emails"]
        domains = [e.split("@")[1] for e in emails]
        counts = Counter(domains)

        print("Email Domain Distribution:")
        print("-" * 30)

        for domain, count in counts.most_common():
            print(f"{domain:20} {'█' * count} ({count})")

        subs = data["findings"]["subdomains"]
        print(f"\nTotal Subdomains Found: {len(subs)}")
        print("-" * 30)

        for i, sub in enumerate(subs[:10], 1):
            print(f"{i}. {sub}")

    except Exception as e:
        print(f"Error: {e}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 visualize_results.py <json_report>")
        sys.exit(1)

    create_simple_charts(sys.argv[1])
