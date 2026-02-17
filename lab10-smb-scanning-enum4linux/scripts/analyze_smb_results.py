#!/usr/bin/env python3
"""
Lab 10 – SMB Scanning with Enum4Linux
SMB Enumeration Results Analyzer
Parses enum4linux output and generates structured analysis.
"""

import os
import re
import sys
from datetime import datetime


def analyze_users(file_path):
    """Extract discovered users from enumeration output"""
    users = []

    try:
        with open(file_path, 'r') as f:
            content = f.read()

        # Extract usernames in format: user:[username]
        user_matches = re.findall(r'user:\[([^\]]+)\]', content)
        users.extend(user_matches)

        # Extract RID cycling results
        rid_matches = re.findall(
            r'S-1-5-21-\d+-\d+-\d+-(\d+)\s+(\w+)',
            content
        )

        for rid, username in rid_matches:
            if username not in users:
                users.append(username)

    except FileNotFoundError:
        print(f"[!] Users file not found: {file_path}")

    return list(set(users))


def analyze_shares(file_path):
    """Extract share information"""
    shares = []

    try:
        with open(file_path, 'r') as f:
            content = f.read()

        share_section = re.search(
            r'Sharename\s+Type\s+Comment\s*\n\s*-+\s*\n(.*?)(?=\n\n|\Z)',
            content,
            re.DOTALL
        )

        if share_section:
            lines = share_section.group(1).strip().split('\n')
            for line in lines:
                line = line.strip()
                if line and not line.startswith('-'):
                    parts = line.split()
                    if parts:
                        shares.append(parts[0])

    except FileNotFoundError:
        print(f"[!] Shares file not found: {file_path}")

    return list(set(shares))


def generate_security_recommendations(users, shares):
    """Generate risk-based recommendations"""
    recommendations = []

    if users:
        recommendations.append("Review discovered user accounts for unnecessary access.")
        recommendations.append("Implement strong password policies.")
        recommendations.append("Disable unused or test accounts.")

    if shares:
        recommendations.append("Review SMB share permissions carefully.")
        recommendations.append("Remove unnecessary or public shares.")
        recommendations.append("Restrict access using proper ACL controls.")

    recommendations.append("Disable SMBv1 if enabled.")
    recommendations.append("Enable SMB logging and auditing.")
    recommendations.append("Monitor unusual SMB authentication attempts.")

    return recommendations


def main():
    if len(sys.argv) != 2:
        print("Usage: python3 analyze_smb_results.py <results_directory>")
        sys.exit(1)

    results_dir = sys.argv[1]

    print("=" * 60)
    print("SMB ENUMERATION ANALYSIS REPORT")
    print("=" * 60)
    print(f"Analysis Date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"Results Directory: {results_dir}")
    print()

    # Analyze users
    users_file = os.path.join(results_dir, "users.txt")
    users = analyze_users(users_file)

    print("DISCOVERED USERS:")
    print("-" * 30)
    if users:
        for user in users:
            print(f" • {user}")
    else:
        print(" No users discovered.")
    print()

    # Analyze shares
    shares_file = os.path.join(results_dir, "shares.txt")
    shares = analyze_shares(shares_file)

    print("DISCOVERED SHARES:")
    print("-" * 30)
    if shares:
        for share in shares:
            print(f" • {share}")
    else:
        print(" No shares discovered.")
    print()

    # Security recommendations
    print("SECURITY RECOMMENDATIONS:")
    print("-" * 30)
    recommendations = generate_security_recommendations(users, shares)
    for rec in recommendations:
        print(f" • {rec}")

    print()
    print("=" * 60)
    print("Analysis Complete.")
    print("=" * 60)


if __name__ == "__main__":
    main()
