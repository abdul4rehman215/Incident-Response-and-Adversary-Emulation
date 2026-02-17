#!/usr/bin/env python3

from scapy.all import sniff, DNS
from collections import defaultdict, deque
from datetime import datetime, timedelta
import re
import statistics
import sys

class DNSMonitor:

    def __init__(self, interface="eth0"):
        self.interface = interface
        self.query_history = defaultdict(deque)
        self.suspicious_keywords = ['malware', 'phishing', 'trojan', 'botnet']
        self.suspicious_tlds = ['.tk', '.ml', '.ga']

    def is_dga_domain(self, domain):
        sub = domain.split('.')[0]

        vowels = len(re.findall(r'[aeiou]', sub))
        consonants = len(re.findall(r'[bcdfghjklmnpqrstvwxyz]', sub))

        if len(sub) > 12 and consonants > vowels * 3:
            return True
        return False

    def is_suspicious_domain(self, domain):

        if any(keyword in domain.lower() for keyword in self.suspicious_keywords):
            return True, "Suspicious keyword in domain"

        if any(domain.endswith(tld) for tld in self.suspicious_tlds):
            return True, "Suspicious TLD"

        if self.is_dga_domain(domain):
            return True, "DGA-like pattern detected"

        return False, ""

    def analyze_query_frequency(self, domain):

        now = datetime.now()
        history = self.query_history[domain]
        history.append(now)

        while history and history[0] < now - timedelta(minutes=5):
            history.popleft()

        if len(history) > 20:
            return True, "High frequency query detected (possible beaconing)"

        return False, ""

    def detect_beaconing(self, domain):

        history = self.query_history[domain]

        if len(history) < 10:
            return False

        intervals = []
        for i in range(1, len(history)):
            intervals.append((history[i] - history[i-1]).total_seconds())

        if len(intervals) < 5:
            return False

        std_dev = statistics.stdev(intervals)

        if std_dev < 2:
            return True

        return False

    def process_dns_packet(self, packet):

        if packet.haslayer(DNS):
            dns_layer = packet[DNS]

            if dns_layer.qr == 0 and dns_layer.qd:
                domain = dns_layer.qd.qname.decode('utf-8').rstrip('.')
                src_ip = packet[0][1].src

                suspicious, reason = self.is_suspicious_domain(domain)
                freq_suspicious, freq_reason = self.analyze_query_frequency(domain)
                beaconing = self.detect_beaconing(domain)

                if suspicious:
                    print(f"[ALERT] Suspicious Domain: {domain}")
                    print(f"Reason: {reason}")
                    print(f"Source IP: {src_ip}\n")

                if freq_suspicious:
                    print(f"[ALERT] Frequency Anomaly: {domain}")
                    print(f"Reason: {freq_reason}")
                    print(f"Source IP: {src_ip}\n")

                if beaconing:
                    print(f"[ALERT] Beaconing Detected: {domain}")
                    print(f"Source IP: {src_ip}\n")

    def start_monitoring(self):

        print(f"[+] Monitoring DNS on {self.interface}")
        print("[+] Press Ctrl+C to stop\n")

        try:
            sniff(
                iface=self.interface,
                filter="port 53",
                prn=self.process_dns_packet,
                store=False
            )
        except KeyboardInterrupt:
            print("\nMonitoring stopped.")

def main():

    interface = "eth0"

    if len(sys.argv) == 2:
        interface = sys.argv[1]

    monitor = DNSMonitor(interface)
    monitor.start_monitoring()

if __name__ == "__main__":
    main()
