#!/usr/bin/env python3

"""
Recon-ng Automation Script
Automates reconnaissance data collection using Recon-ng framework.
"""

import subprocess
import sys
import os

def run_recon_ng(domain):
    commands = [
        "marketplace install hackertarget",
        "modules load recon/domains-hosts/hackertarget",
        f"options set SOURCE {domain}",
        "run",
        "show hosts",
        "exit"
    ]

    command_file = "recon_commands.txt"

    with open(command_file, "w") as f:
        for cmd in commands:
            f.write(cmd + "\n")

    try:
        subprocess.run([
            "python3",
            os.path.expanduser("~/recon-ng/recon-ng"),
            "-r",
            command_file
        ])
        print("[+] Recon-ng automation completed successfully.")
    except Exception as e:
        print(f"[!] Error running Recon-ng automation: {e}")

if __name__ == "__main__":
    domain = sys.argv[1] if len(sys.argv) > 1 else "example-target.com"
    run_recon_ng(domain)
