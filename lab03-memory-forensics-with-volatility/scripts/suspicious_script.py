#!/usr/bin/env python3

import time
import os
import socket

def suspicious_activity():
    while True:
        try:
            with open('/etc/passwd', 'r') as f:
                f.read()
        except:
            pass

        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(1)
            s.connect(('127.0.0.1', 8080))
            s.close()
        except:
            pass

        time.sleep(5)

if __name__ == "__main__":
    suspicious_activity()
