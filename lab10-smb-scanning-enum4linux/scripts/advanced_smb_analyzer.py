#!/usr/bin/env python3
"""
Lab 10 – SMB Scanning with Enum4Linux
Advanced SMB Enumeration and Risk Analysis Tool

Features:
- Runs enum4linux automatically
- Extracts users, shares, OS info
- Performs security risk assessment
- Generates JSON detailed report
- Generates human-readable summary report
"""

import subprocess
import json
import re
import os
import argparse
from datetime import datetime


class AdvancedSMBAnalyzer:

    def __init__(self):
        self.results = {}

    # -------------------------------------------------
    # Extract Users
    # -------------------------------------------------
    def extract_users(self, enum_output):
        users = []

        user_patterns = [
            r'user:\[([^\]]+)\]',
            r'S-1-5-21-\d+-\d+-\d+-\d+\s+(\w+)\s+\(Local User\)',
            r'(\w+)\s+\(Local User\)'
        ]

        for pattern in user_patterns:
            matches = re.findall(pattern, enum_output, re.IGNORECASE)
            users.extend(matches)

        users = list(set(users))

        system_accounts = [
            'nobody', 'root', 'daemon', 'bin', 'sys',
            'sync', 'games', 'man', 'lp', 'mail',
            'news', 'uucp', 'proxy', 'www-data',
            'backup', 'list', 'irc', 'gnats'
        ]

        users = [
            u for u in users
            if u.lower() not in system_accounts and len(u) > 2
        ]

        return users

    # -------------------------------------------------
    # Extract Shares
    # -------------------------------------------------
    def extract_shares(self, enum_output):
        shares = []

        share_section = re.search(
            r'Sharename\s+Type\s+Comment.*?\n(.*?)(?=\n\n|\Z)',
            enum_output,
            re.DOTALL
        )

        if share_section:
            lines = share_section.group(1).split('\n')

            for line in lines:
                line = line.strip()

                if (
                    line and
                    not line.startswith('-') and
                    not line.startswith('Sharename')
                ):
                    parts = line.split()

                    if parts and parts[0] not in ['IPC$', 'print$']:
                        share_info = {
                            'name': parts[0],
                            'type': parts[1] if len(parts) > 1 else 'Unknown',
                            'comment': ' '.join(parts[2:]) if len(parts) > 2 else ''
                        }
                        shares.append(share_info)

        return shares

    # -------------------------------------------------
    # Extract OS Information
    # -------------------------------------------------
    def extract_os_info(self, enum_output):
        os_info = {}

        os_patterns = {
            'os': r'OS=\[([^\]]+)\]',
            'server': r'Server=\[([^\]]+)\]',
            'domain': r'Domain=\[([^\]]+)\]',
            'workgroup': r'Workgroup=\[([^\]]+)\]'
        }

        for key, pattern in os_patterns.items():
            match = re.search(pattern, enum_output)
            if match:
                os_info[key] = match.group(1)

        return os_info

    # -------------------------------------------------
    # Security Risk Assessment
    # -------------------------------------------------
    def assess_security_risks(self, target_data):

        risks = []

        users = target_data.get('users', [])
        shares = target_data.get('shares', [])

        # Weak usernames
        weak_usernames = [
            'admin', 'administrator', 'guest',
            'test', 'user', 'demo'
        ]

        weak_found = [
            u for u in users
            if u.lower() in weak_usernames
        ]

        if weak_found:
            risks.append({
                'level': 'HIGH',
                'type': 'Weak Usernames',
                'description': f"Found predictable usernames: {', '.join(weak_found)}",
                'recommendation': 'Rename or disable predictable accounts'
            })

        # Excessive shares
        if len(shares) > 5:
            risks.append({
                'level': 'MEDIUM',
                'type': 'Excessive Shares',
                'description': f"{len(shares)} shares detected",
                'recommendation': 'Review and remove unnecessary shares'
            })

        # Sensitive share names
        risky_keywords = [
            'backup', 'admin', 'confidential',
            'private', 'secret'
        ]

        sensitive = [
            s['name']
            for s in shares
            if any(word in s['name'].lower() for word in risky_keywords)
        ]

        if sensitive:
            risks.append({
                'level': 'HIGH',
                'type': 'Sensitive Share Names',
                'description': f"Sensitive share names detected: {', '.join(sensitive)}",
                'recommendation': 'Restrict access and review permissions'
            })

        return risks

    # -------------------------------------------------
    # Perform Full Analysis
    # -------------------------------------------------
    def analyze_target(self, target, enum_output):

        analysis = {
            'target': target,
            'timestamp': datetime.now().isoformat(),
            'users': self.extract_users(enum_output),
            'shares': self.extract_shares(enum_output),
            'os_info': self.extract_os_info(enum_output),
            'security_risks': []
        }

        analysis['security_risks'] = self.assess_security_risks(analysis)

        return analysis

    # -------------------------------------------------
    # Run Enumeration
    # -------------------------------------------------
    def run_enumeration(self, target):
        try:
            cmd = ['enum4linux', '-a', target]
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=300
            )

            if result.returncode == 0:
                return result.stdout
            else:
                print(f"[-] enum4linux failed: {result.stderr}")
                return None

        except subprocess.TimeoutExpired:
            print(f"[-] Timeout scanning {target}")
            return None

        except Exception as e:
            print(f"[-] Error scanning {target}: {e}")
            return None

    # -------------------------------------------------
    # Generate JSON Report
    # -------------------------------------------------
    def generate_detailed_report(self, output_file):

        with open(output_file, 'w') as f:
            json.dump(self.results, f, indent=2)

        print(f"[+] Detailed JSON report saved to {output_file}")

    # -------------------------------------------------
    # Generate Summary Report
    # -------------------------------------------------
    def generate_summary_report(self, output_file):

        with open(output_file, 'w') as f:
            f.write("SMB ENUMERATION SUMMARY REPORT\n")
            f.write("=" * 50 + "\n")
            f.write(f"Generated: {datetime.now()}\n")
            f.write(f"Targets Analyzed: {len(self.results)}\n\n")

            for target, data in self.results.items():
                f.write(f"TARGET: {target}\n")
                f.write("-" * 40 + "\n")

                if data.get('os_info'):
                    f.write("OS INFORMATION:\n")
                    for k, v in data['os_info'].items():
                        f.write(f" {k}: {v}\n")
                    f.write("\n")

                f.write(f"Users Found ({len(data['users'])}):\n")
                for user in data['users']:
                    f.write(f" • {user}\n")
                f.write("\n")

                f.write(f"Shares Found ({len(data['shares'])}):\n")
                for share in data['shares']:
                    f.write(f" • {share['name']} ({share['type']}) - {share['comment']}\n")
                f.write("\n")

                if data['security_risks']:
                    f.write("SECURITY RISKS:\n")
                    for risk in data['security_risks']:
                        f.write(f" [{risk['level']}] {risk['type']}\n")
                        f.write(f" Description: {risk['description']}\n")
                        f.write(f" Recommendation: {risk['recommendation']}\n\n")

                f.write("=" * 50 + "\n\n")

        print(f"[+] Summary report saved to {output_file}")


# -------------------------------------------------
# Main Execution
# -------------------------------------------------
def main():

    parser = argparse.ArgumentParser(description="Advanced SMB Analyzer")
    parser.add_argument('target', help="Target IP address")
    parser.add_argument('--json-output', default='detailed_smb_report.json')
    parser.add_argument('--summary-output', default='smb_summary_report.txt')

    args = parser.parse_args()

    analyzer = AdvancedSMBAnalyzer()

    print(f"[+] Starting advanced SMB analysis of {args.target}")

    enum_output = analyzer.run_enumeration(args.target)

    if enum_output:
        analysis = analyzer.analyze_target(args.target, enum_output)
        analyzer.results[args.target] = analysis

        analyzer.generate_detailed_report(args.json_output)
        analyzer.generate_summary_report(args.summary_output)

        print(f"[+] Analysis completed for {args.target}")
        print(f"[+] Found {len(analysis['users'])} users and {len(analysis['shares'])} shares")

        if analysis['security_risks']:
            print(f"[!] Identified {len(analysis['security_risks'])} security risks")
    else:
        print("[-] Enumeration failed")


if __name__ == "__main__":
    main()
