#!/usr/bin/env python3
"""
theHarvester Automation Script
Automates OSINT gathering and generates formatted reports
"""

import subprocess
import json
import datetime
import os
import sys


class HarvesterAutomation:
    def __init__(self, domain, output_dir="harvester_reports"):
        self.domain = domain
        self.output_dir = output_dir
        self.timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")

        if not os.path.exists(self.output_dir):
            os.makedirs(self.output_dir)

    def run_harvester(self, sources, limit=200):
        """Run theHarvester with specified sources"""
        output_file = f"{self.output_dir}/{self.domain}_{self.timestamp}"

        cmd = [
            "python3", "theHarvester.py",
            "-d", self.domain,
            "-l", str(limit),
            "-b", sources,
            "-f", output_file
        ]

        try:
            print(f"Running theHarvester for {self.domain}...")
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                cwd=os.path.expanduser("~/theHarvester")
            )

            if result.returncode == 0:
                print(f"Successfully completed scan for {self.domain}")
                return output_file
            else:
                print(f"Error running theHarvester: {result.stderr}")
                return None

        except Exception as e:
            print(f"Exception occurred: {str(e)}")
            return None

    def generate_report(self, scan_results):
        """Generate formatted HTML report"""
        report_file = f"{self.output_dir}/{self.domain}_report_{self.timestamp}.html"

        html_content = f"""
<!DOCTYPE html>
<html>
<head>
<title>OSINT Report for {self.domain}</title>
<style>
body {{ font-family: Arial; margin: 20px; }}
.header {{ background-color: #f0f0f0; padding: 10px; }}
.section {{ margin: 20px 0; }}
.data {{ background-color: #f9f9f9; padding: 10px; border-left: 3px solid #007acc; }}
pre {{ background-color: #f5f5f5; padding: 10px; overflow-x: auto; }}
</style>
</head>
<body>

<div class="header">
<h1>OSINT Report for {self.domain}</h1>
<p>Generated on: {datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")}</p>
</div>

<div class="section">
<h2>Scan Summary</h2>
<div class="data">
<p><strong>Target Domain:</strong> {self.domain}</p>
<p><strong>Scan Timestamp:</strong> {self.timestamp}</p>
<p><strong>Tool Used:</strong> theHarvester</p>
</div>
</div>

<div class="section">
<h2>Raw Results</h2>
<pre>{scan_results}</pre>
</div>

</body>
</html>
"""

        with open(report_file, "w") as f:
            f.write(html_content)

        print(f"Report generated: {report_file}")
        return report_file


def main():
    if len(sys.argv) != 2:
        print("Usage: python3 harvester_automation.py <domain>")
        sys.exit(1)

    domain = sys.argv[1]
    harvester = HarvesterAutomation(domain)

    sources = "google,bing,dnsdumpster,crtsh"
    output_file = harvester.run_harvester(sources)

    if output_file:
        try:
            with open(f"{output_file}.json", "r") as f:
                results = f.read()
                harvester.generate_report(results)
        except FileNotFoundError:
            harvester.generate_report("Scan completed. Check result files.")


if __name__ == "__main__":
    main()
