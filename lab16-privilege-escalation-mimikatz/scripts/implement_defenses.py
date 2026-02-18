#!/usr/bin/env python3
# File: implement_defenses.py

import subprocess
import json
import os
from datetime import datetime


class SecurityHardening:

    def __init__(self):
        self.recommendations = []
        self.implemented = []
        self.timestamp = datetime.now().isoformat()

    def disable_wdigest(self):

        print("[*] Checking WDigest configuration...")

        check_cmd = [
            "pwsh",
            "-Command",
            "Get-ItemProperty -Path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\WDigest' -Name UseLogonCredential -ErrorAction SilentlyContinue"
        ]

        result = subprocess.run(check_cmd, capture_output=True, text=True)

        if "UseLogonCredential" in result.stdout:
            print("[*] Disabling WDigest...")
            disable_cmd = [
                "pwsh",
                "-Command",
                "Set-ItemProperty -Path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\WDigest' -Name UseLogonCredential -Value 0"
            ]
            subprocess.run(disable_cmd)
            self.implemented.append("WDigest disabled")
        else:
            self.recommendations.append("WDigest registry key not found or already disabled")

    def enable_lsa_protection(self):

        print("[*] Enabling LSA Protection...")

        cmd = [
            "pwsh",
            "-Command",
            "Set-ItemProperty -Path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\Lsa' -Name RunAsPPL -Value 1"
        ]

        subprocess.run(cmd)
        self.implemented.append("LSA Protection enabled (reboot required)")

    def configure_credential_guard(self):

        print("[*] Checking Credential Guard compatibility...")

        self.recommendations.append(
            "Credential Guard requires Windows 10 Enterprise, TPM 2.0, Secure Boot enabled."
        )
        self.recommendations.append(
            "Enable via Group Policy: Computer Configuration > Administrative Templates > System > Device Guard."
        )

    def implement_laps(self):

        self.recommendations.append(
            "Install Microsoft LAPS from official source."
        )
        self.recommendations.append(
            "Extend Active Directory schema for LAPS attributes."
        )
        self.recommendations.append(
            "Configure GPO for password rotation policy."
        )

    def configure_audit_policies(self):

        print("[*] Enabling credential auditing policies...")

        commands = [
            "AuditPol /set /subcategory:'Credential Validation' /success:enable /failure:enable",
            "AuditPol /set /subcategory:'Logon' /success:enable /failure:enable",
            "AuditPol /set /subcategory:'Sensitive Privilege Use' /success:enable /failure:enable"
        ]

        for cmd in commands:
            subprocess.run(["pwsh", "-Command", cmd])

        self.implemented.append("Audit policies configured")

    def generate_hardening_report(self):

        report = {
            "timestamp": self.timestamp,
            "implemented_measures": self.implemented,
            "remaining_recommendations": self.recommendations
        }

        with open("hardening_report.json", "w") as f:
            json.dump(report, f, indent=4)

        print("\n=== Security Hardening Report ===")
        print(f"Implemented: {len(self.implemented)}")
        print(f"Recommendations: {len(self.recommendations)}")
        print("Report saved to hardening_report.json")


def main():

    hardening = SecurityHardening()

    hardening.disable_wdigest()
    hardening.enable_lsa_protection()
    hardening.configure_credential_guard()
    hardening.implement_laps()
    hardening.configure_audit_policies()
    hardening.generate_hardening_report()


if __name__ == "__main__":
    main()
