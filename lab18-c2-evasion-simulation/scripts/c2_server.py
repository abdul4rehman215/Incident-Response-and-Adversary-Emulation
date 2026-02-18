#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer
import json
import logging
from datetime import datetime

LOG_FILE = "../logs/c2_server.log"

class C2Handler(BaseHTTPRequestHandler):

    def log_beacon(self, client_ip, user_agent):
        log_entry = f"[{datetime.utcnow()}] Beacon from {client_ip} UA:{user_agent}\n"
        with open(LOG_FILE, "a") as f:
            f.write(log_entry)

    def do_GET(self):
        client_ip = self.client_address[0]
        user_agent = self.headers.get("User-Agent")

        self.log_beacon(client_ip, user_agent)

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
