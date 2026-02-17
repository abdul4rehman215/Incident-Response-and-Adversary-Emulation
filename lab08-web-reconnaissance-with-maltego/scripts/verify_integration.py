#!/usr/bin/env python3

import subprocess
import sys

def test_command(command, description):
    print(f"Testing {description}...")
    try:
        result = subprocess.run(
            command,
            shell=True,
            capture_output=True,
            text=True,
            timeout=30
        )

        if result.returncode == 0:
            print(f" ✓ {description} - PASSED")
            return True
        else:
            print(f" ✗ {description} - FAILED")
            print(result.stderr.strip())
            return False

    except Exception as e:
        print(f" ✗ {description} - ERROR: {e}")
        return False

def main():
    print("Maltego OSINT Integration Verification")
    print("=" * 50)

    tests = [
        ("java -version", "Java Runtime"),
        ("maltego --version", "Maltego Installation"),
        ("theharvester --help", "theHarvester"),
        ("python3 ~/Sublist3r/sublist3r.py --help", "Sublist3r"),
        ("dnsrecon --help", "DNSrecon"),
        ("shodan --help", "Shodan CLI"),
        ("python3 ~/recon-ng/recon-ng --help", "Recon-ng")
    ]

    passed = 0

    for command, description in tests:
        if test_command(command, description):
            passed += 1

    print("\n" + "=" * 50)
    print(f"Verification Results: {passed}/{len(tests)} tests passed")

if __name__ == "__main__":
    main()
