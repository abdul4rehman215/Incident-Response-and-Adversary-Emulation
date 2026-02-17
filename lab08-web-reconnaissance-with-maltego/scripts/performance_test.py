#!/usr/bin/env python3

import time
import subprocess
import statistics

def time_command(command, iterations=3):
    times = []

    for _ in range(iterations):
        start = time.time()
        try:
            result = subprocess.run(
                command,
                shell=True,
                capture_output=True,
                text=True,
                timeout=60
            )
            if result.returncode == 0:
                times.append(time.time() - start)
        except Exception:
            pass

    if times:
        return statistics.mean(times)
    return None

def main():
    print("Performance Testing OSINT Tools")
    print("=" * 40)

    test_domain = "example.com"

    tests = [
        (f"theharvester -d {test_domain} -l 10 -b google", "theHarvester"),
        (f"dnsrecon -d {test_domain} -t std", "DNSrecon"),
        (f"nslookup {test_domain}", "DNS Lookup")
    ]

    for command, name in tests:
        print(f"\nTesting {name}...")
        avg = time_command(command)
        if avg:
            print(f" Average execution time: {avg:.2f} seconds")
        else:
            print(" Failed to complete test")

if __name__ == "__main__":
    main()
