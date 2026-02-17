#!/usr/bin/env python3

"""
Email Analysis Script
Extracts and groups email addresses by domain.
"""

import re
from collections import defaultdict

def analyze_emails(email_file):
    try:
        with open(email_file, 'r') as f:
            content = f.read()

        emails = re.findall(
            r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b',
            content
        )

        domain_groups = defaultdict(list)

        for email in emails:
            domain = email.split('@')[1]
            domain_groups[domain].append(email)

        print("Email Analysis Results:")
        print("=" * 50)

        for domain, email_list in domain_groups.items():
            print(f"\nDomain: {domain}")
            print(f"Email count: {len(email_list)}")
            print("Emails:")
            for email in email_list:
                print(f" - {email}")

        return domain_groups

    except FileNotFoundError:
        print(f"[!] File {email_file} not found.")
        return {}

if __name__ == "__main__":
    analyze_emails('harvester_results.txt')
