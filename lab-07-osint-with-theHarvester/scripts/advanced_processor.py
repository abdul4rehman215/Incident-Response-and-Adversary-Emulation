#!/usr/bin/env python3
"""
Advanced theHarvester Data Processor
Processes and analyzes OSINT data with enhanced reporting
"""

import subprocess
import json
import csv
import re
import datetime
import os
import sys
from collections import Counter


class AdvancedHarvesterProcessor:

    def __init__(self, domain):
        self.domain = domain
        self.timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
        self.results = {
            "emails": [],
            "subdomains": [],
            "hosts": [],
            "urls": []
        }

    def extract_emails(self, text):
        email_pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b'
        return list(set(re.findall(email_pattern, text)))

    def extract_subdomains(self, text):
        pattern = rf'\b[\w.-]*\.{re.escape(self.domain)}\b'
        return list(set(re.findall(pattern, text, re.IGNORECASE)))

    def process_output(self, output_text):
        self.results["emails"] = self.extract_emails(output_text)
        self.results["subdomains"] = self.extract_subdomains(output_text)

        for line in output_text.splitlines():
            if "http" in line.lower():
                self.results["urls"].append(line.strip())

    def generate_csv_reports(self):
        reports = []

        email_file = f"emails_{self.domain}_{self.timestamp}.csv"
        with open(email_file, "w", newline="") as f:
            writer = csv.writer(f)
            writer.writerow(["Email", "Domain"])
            for email in self.results["emails"]:
                writer.writerow([email, email.split("@")[1]])
        reports.append(email_file)

        sub_file = f"subdomains_{self.domain}_{self.timestamp}.csv"
        with open(sub_file, "w", newline="") as f:
            writer = csv.writer(f)
            writer.writerow(["Subdomain", "Root Domain"])
            for sub in self.results["subdomains"]:
                writer.writerow([sub, self.domain])
        reports.append(sub_file)

        return reports

    def generate_statistics(self):
        return {
            "total_emails": len(self.results["emails"]),
            "total_subdomains": len(self.results["subdomains"]),
            "total_urls": len(self.results["urls"]),
            "unique_email_domains": len(
                set([e.split("@")[1] for e in self.results["emails"]])
            )
        }

    def create_json_report(self):
        report_data = {
            "scan_info": {
                "domain": self.domain,
                "timestamp": self.timestamp
            },
            "statistics": self.generate_statistics(),
            "findings": self.results
        }

        filename = f"comprehensive_report_{self.domain}_{self.timestamp}.json"
        with open(filename, "w") as f:
            json.dump(report_data, f, indent=2)

        return filename


def run_automated_scan(domain):
    processor = AdvancedHarvesterProcessor(domain)

    source_sets = ["google,bing", "dnsdumpster,crtsh", "virustotal"]
    combined_output = ""

    for sources in source_sets:
        print(f"Running scan with sources: {sources}")

        cmd = [
            "python3", "theHarvester.py",
            "-d", domain,
            "-l", "200",
            "-b", sources
        ]

        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            cwd=os.path.expanduser("~/theHarvester")
        )

        combined_output += result.stdout
        print(f"Completed scan with {sources}")

    processor.process_output(combined_output)

    csv_reports = processor.generate_csv_reports()
    json_report = processor.create_json_report()

    print("\nGenerated Reports:")
    for r in csv_reports + [json_report]:
        print(f" - {r}")

    return processor.results


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 advanced_processor.py <domain>")
        sys.exit(1)

    domain = sys.argv[1]
    results = run_automated_scan(domain)

    print(f"\nSummary for {domain}:")
    print(f"Emails found: {len(results['emails'])}")
    print(f"Subdomains found: {len(results['subdomains'])}")
    print(f"URLs found: {len(results['urls'])}")
