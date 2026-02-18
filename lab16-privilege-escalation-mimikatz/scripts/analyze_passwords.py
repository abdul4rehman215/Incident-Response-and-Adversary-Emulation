#!/usr/bin/env python3
# File: analyze_passwords.py

import json
import re
import hashlib
import os


def analyze_password_strength(password):

    analysis = {
        'score': 0,
        'strength': 'Weak',
        'feedback': []
    }

    length = len(password)

    if length >= 8:
        analysis['score'] += 2
    else:
        analysis['feedback'].append("Password is shorter than 8 characters.")

    if length >= 12:
        analysis['score'] += 2

    if re.search(r"[A-Z]", password):
        analysis['score'] += 1
    else:
        analysis['feedback'].append("Add uppercase letters.")

    if re.search(r"[a-z]", password):
        analysis['score'] += 1
    else:
        analysis['feedback'].append("Add lowercase letters.")

    if re.search(r"[0-9]", password):
        analysis['score'] += 1
    else:
        analysis['feedback'].append("Add digits.")

    if re.search(r"[!@#$%^&*()_+=\-{}\[\]:;\"'<>,.?/]", password):
        analysis['score'] += 1
    else:
        analysis['feedback'].append("Add special characters.")

    common_patterns = ["password", "admin", "welcome", "1234", "qwerty"]

    for pattern in common_patterns:
        if pattern.lower() in password.lower():
            analysis['score'] -= 2
            analysis['feedback'].append("Contains common weak pattern.")
            break

    if analysis['score'] >= 8:
        analysis['strength'] = "Strong"
    elif analysis['score'] >= 5:
        analysis['strength'] = "Moderate"
    else:
        analysis['strength'] = "Weak"

    return analysis


def check_hash_vulnerability(ntlm_hash):

    weak_hashes = {
        "31d6cfe0d16ae931b73c59d7e0c089c0": "Empty password",
    }

    result = {
        "hash": ntlm_hash,
        "risk": "Unknown",
        "notes": []
    }

    if ntlm_hash.lower() in weak_hashes:
        result["risk"] = "Critical"
        result["notes"].append(weak_hashes[ntlm_hash.lower()])
    else:
        result["risk"] = "Medium"

    return result


def generate_security_report(credentials):

    report = {
        "analyzed_accounts": [],
        "high_risk_accounts": []
    }

    for cred in credentials:
        password_analysis = analyze_password_strength(cred.get("password", ""))
        hash_analysis = check_hash_vulnerability(cred.get("ntlm_hash", ""))

        account_report = {
            "username": cred.get("username"),
            "domain": cred.get("domain"),
            "password_strength": password_analysis,
            "hash_risk": hash_analysis
        }

        report["analyzed_accounts"].append(account_report)

        if password_analysis["strength"] == "Weak" or hash_analysis["risk"] == "Critical":
            report["high_risk_accounts"].append(cred.get("username"))

    with open("password_security_report.json", "w") as f:
        json.dump(report, f, indent=4)

    print("\n=== Password Security Analysis ===")
    print(f"Total Accounts Analyzed: {len(report['analyzed_accounts'])}")
    print(f"High Risk Accounts: {len(report['high_risk_accounts'])}")
    print("Report saved to password_security_report.json")


if __name__ == "__main__":

    if not os.path.exists("credentials.json"):
        print("[!] credentials.json not found. Run extraction first.")
        exit(1)

    with open("credentials.json", "r") as f:
        credentials = json.load(f)

    generate_security_report(credentials)
