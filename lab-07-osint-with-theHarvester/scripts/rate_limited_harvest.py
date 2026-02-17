#!/usr/bin/env python3
"""
Rate-limited theHarvester wrapper
"""

import time
import subprocess
import sys
import os


def rate_limited_harvest(domain, sources, delay=5):
    source_list = sources.split(",")

    for source in source_list:
        print(f"Scanning {domain} using {source}...")

        cmd = [
            "python3", "theHarvester.py",
            "-d", domain,
            "-l", "50",
            "-b", source,
            "-f", f"{domain}_{source}"
        ]

        subprocess.run(
            cmd,
            cwd=os.path.expanduser("~/theHarvester")
        )

        print(f"Completed scan with {source}")

        if source != source_list[-1]:
            print(f"Waiting {delay} seconds...")
            time.sleep(delay)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 rate_limited_harvest.py <domain> <sources>")
        sys.exit(1)

    rate_limited_harvest(sys.argv[1], sys.argv[2])
