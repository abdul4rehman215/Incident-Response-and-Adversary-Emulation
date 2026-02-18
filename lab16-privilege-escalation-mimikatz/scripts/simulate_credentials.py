#!/usr/bin/env python3
# File: simulate_credentials.py

import os
import json
import hashlib
import struct
from datetime import datetime


def ntlm_hash(password):
    """
    Generate NTLM hash of a password.
    """
    password = password.encode('utf-16le')
    return hashlib.new('md4', password).hexdigest()


def generate_simulated_credentials():
    """
    Generate simulated Windows credential structures for testing.
    """

    credentials = [
        {
            'username': 'administrator',
            'domain': 'CORPORATE',
            'password': 'P@ssw0rd123!',
            'account_type': 'admin'
        },
        {
            'username': 'jdoe',
            'domain': 'CORPORATE',
            'password': 'Welcome2024',
            'account_type': 'user'
        },
        {
            'username': 'svc_backup',
            'domain': 'CORPORATE',
            'password': 'Backup@123',
            'account_type': 'service'
        }
    ]

    for cred in credentials:
        cred['ntlm_hash'] = ntlm_hash(cred['password'])

    return credentials


def create_memory_dump(credentials):
    """
    Create simulated LSASS memory dump file.
    """

    dump_file = "simulated_lsass.dmp"

    with open(dump_file, "wb") as f:
        for cred in credentials:
            entry = (
                f"Username:{cred['username']}\n"
                f"Domain:{cred['domain']}\n"
                f"Password:{cred['password']}\n"
                f"NTLM:{cred['ntlm_hash']}\n"
                f"AccountType:{cred['account_type']}\n"
                f"Timestamp:{datetime.now().isoformat()}\n"
                "----\n"
            )
            f.write(entry.encode())

    with open("credentials.json", "w") as json_file:
        json.dump(credentials, json_file, indent=4)

    print(f"[+] Simulated LSASS dump created: {dump_file}")
    print("[+] Credential JSON saved as credentials.json")


if __name__ == "__main__":
    creds = generate_simulated_credentials()
    create_memory_dump(creds)
    print("[+] Simulated environment created")
