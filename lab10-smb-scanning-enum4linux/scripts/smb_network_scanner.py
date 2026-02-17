#!/usr/bin/env python3
"""
Lab 10 – SMB Scanning with Enum4Linux
SMB Network Scanner
Automates SMB enumeration across multiple targets using threading.
"""

import subprocess
import threading
import argparse
import ipaddress
import os
import time
import socket
from concurrent.futures import ThreadPoolExecutor, as_completed


class SMBScanner:

    def __init__(self, max_threads=10):
        self.max_threads = max_threads
        self.results = {}
        self.lock = threading.Lock()

    # -----------------------------------------------------
    # Check if SMB Port 445 is Open
    # -----------------------------------------------------
    def check_smb_port(self, target, port=445, timeout=3):
        try:
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            sock.settimeout(timeout)
            result = sock.connect_ex((str(target), port))
            sock.close()
            return result == 0
        except Exception:
            return False

    # -----------------------------------------------------
    # Run Enum4Linux
    # -----------------------------------------------------
    def run_enum4linux(self, target):
        try:
            timestamp = int(time.time())
            output_dir = f"smb_scan_{target}_{timestamp}"
            os.makedirs(output_dir, exist_ok=True)

            cmd = ['enum4linux', '-a', str(target)]
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=300
            )

            output_file = os.path.join(output_dir, 'enum4linux_output.txt')

            with open(output_file, 'w') as f:
                f.write(f"Target: {target}\n")
                f.write(f"Command: {' '.join(cmd)}\n")
                f.write("=" * 60 + "\n")
                f.write(result.stdout)
                if result.stderr:
                    f.write("\nERRORS:\n")
                    f.write(result.stderr)

            return {
                'target': str(target),
                'success': result.returncode == 0,
                'output_file': output_file,
                'stdout': result.stdout,
                'stderr': result.stderr
            }

        except subprocess.TimeoutExpired:
            return {
                'target': str(target),
                'success': False,
                'error': 'Timeout expired',
                'output_file': None
            }

        except Exception as e:
            return {
                'target': str(target),
                'success': False,
                'error': str(e),
                'output_file': None
            }

    # -----------------------------------------------------
    # Scan Single Target
    # -----------------------------------------------------
    def scan_target(self, target):
        print(f"[+] Scanning {target}...")

        if not self.check_smb_port(target):
            print(f"[-] SMB port 445 closed on {target}")
            return {
                'target': str(target),
                'success': False,
                'error': 'SMB port closed'
            }

        print(f"[+] SMB port open on {target}, running enumeration...")
        result = self.run_enum4linux(target)

        with self.lock:
            self.results[str(target)] = result

        if result['success']:
            print(f"[+] Enumeration completed for {target}")
        else:
            print(f"[-] Enumeration failed for {target}: {result.get('error', 'Unknown error')}")

        return result

    # -----------------------------------------------------
    # Multi-Target Scan
    # -----------------------------------------------------
    def scan_network(self, targets):
        print(f"[+] Starting SMB enumeration scan of {len(targets)} targets")
        print(f"[+] Using {self.max_threads} threads\n")

        with ThreadPoolExecutor(max_workers=self.max_threads) as executor:
            futures = {executor.submit(self.scan_target, target): target for target in targets}

            for future in as_completed(futures):
                target = futures[future]
                try:
                    future.result()
                except Exception as exc:
                    print(f"[-] {target} generated exception: {exc}")

    # -----------------------------------------------------
    # Generate Summary Report
    # -----------------------------------------------------
    def generate_report(self, output_file='smb_scan_report.txt'):

        successful = [r for r in self.results.values() if r['success']]
        failed = [r for r in self.results.values() if not r['success']]

        with open(output_file, 'w') as f:
            f.write("SMB ENUMERATION SCAN REPORT\n")
            f.write("=" * 50 + "\n")
            f.write(f"Scan Date: {time.strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"Total Targets: {len(self.results)}\n")
            f.write(f"Successful Scans: {len(successful)}\n")
            f.write(f"Failed Scans: {len(failed)}\n\n")

            if successful:
                f.write("SUCCESSFUL SCANS:\n")
                f.write("-" * 20 + "\n")
                for result in successful:
                    f.write(f"Target: {result['target']}\n")
                    f.write(f"Output File: {result['output_file']}\n\n")

            if failed:
                f.write("FAILED SCANS:\n")
                f.write("-" * 15 + "\n")
                for result in failed:
                    f.write(f"Target: {result['target']}\n")
                    f.write(f"Error: {result.get('error', 'Unknown')}\n\n")

        print(f"[+] Report saved to {output_file}")


# ---------------------------------------------------------
# Parse Target Input
# ---------------------------------------------------------
def parse_targets(target_input):

    targets = []

    if os.path.isfile(target_input):
        with open(target_input, 'r') as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('#'):
                    targets.append(line)
    else:
        try:
            network = ipaddress.ip_network(target_input, strict=False)
            targets = [str(ip) for ip in network.hosts()]
        except ValueError:
            targets = [target_input]

    return targets


# ---------------------------------------------------------
# Main Execution
# ---------------------------------------------------------
def main():

    parser = argparse.ArgumentParser(description='Automated SMB Enumeration Scanner')
    parser.add_argument('targets', help='Target IP, CIDR network, or file')
    parser.add_argument('-t', '--threads', type=int, default=10, help='Number of threads')
    parser.add_argument('-o', '--output', default='smb_scan_report.txt', help='Output report file')

    args = parser.parse_args()

    targets = parse_targets(args.targets)

    if not targets:
        print("[-] No valid targets found")
        return

    print(f"[+] Parsed {len(targets)} targets")

    scanner = SMBScanner(max_threads=args.threads)
    scanner.scan_network(targets)
    scanner.generate_report(args.output)

    print("[+] Scan completed!")


if __name__ == "__main__":
    main()
