#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer
import json
from datetime import datetime
import logging

LOG_FILE = "../logs/c2_activity.log"

class C2Handler(BaseHTTPRequestHandler):

    def do_GET(self):
        client_ip = self.client_address[0]
        user_agent = self.headers.get('User-Agent')

        log_entry = f"[{datetime.utcnow()}] Beacon from {client_ip} | UA: {user_agent}\n"

        with open(LOG_FILE, "a") as f:
            f.write(log_entry)

        response = {
            "status": "ok",
            "command": "none",
            "timestamp": datetime.utcnow().isoformat()
        }

        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(json.dumps(response).encode())


def run():
    server = HTTPServer(("0.0.0.0", 8080), C2Handler)
    print("[+] Simulated C2 Server running on port 8080")
    server.serve_forever()


if __name__ == "__main__":
    run()
