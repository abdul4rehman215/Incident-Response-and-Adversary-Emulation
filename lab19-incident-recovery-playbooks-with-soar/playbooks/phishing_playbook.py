#!/usr/bin/env python3

import re
import random
import urllib.parse
import json
from datetime import datetime


class PhishingPlaybook:

    def __init__(self):
        self.execution_log = []

    def analyze_email_headers(self, email_data):

        headers = email_data.get("headers", {})

        spf_fail = "fail" in headers.get("received-spf", "").lower()
        dkim_missing = headers.get("dkim-signature", "") == ""
        dmarc_fail = "fail" in headers.get("authentication-results", "").lower()

        suspicious_score = 0
        if spf_fail:
            suspicious_score += 30
        if dkim_missing:
            suspicious_score += 20
        if dmarc_fail:
            suspicious_score += 30

        result = {
            "spf_fail": spf_fail,
            "dkim_missing": dkim_missing,
            "dmarc_fail": dmarc_fail,
            "risk_score": suspicious_score
        }

        self.execution_log.append({"action": "analyze_headers", "result": result})
        return result

    def extract_urls(self, email_body):

        urls = re.findall(r'https?://[^\s]+', email_body)
        unique_urls = list(set(urls))

        self.execution_log.append({"action": "extract_urls", "urls": unique_urls})
        return unique_urls

    def analyze_urls(self, urls):

        results = []

        for url in urls:
            domain = urllib.parse.urlparse(url).netloc

            risk_score = random.randint(10, 100)
            malicious = risk_score > 70

            result = {
                "url": url,
                "domain": domain,
                "risk_score": risk_score,
                "malicious": malicious
            }

            results.append(result)

        self.execution_log.append({"action": "analyze_urls", "results": results})
        return results

    def quarantine_emails(self, search_criteria):

        quarantined_count = random.randint(1, 5)

        result = {
            "criteria": search_criteria,
            "quarantined_count": quarantined_count,
            "timestamp": datetime.utcnow().isoformat()
        }

        self.execution_log.append({"action": "quarantine_emails", "result": result})
        return result

    def block_malicious_urls(self, urls):

        blocked = []

        for url in urls:
            blocked.append({
                "url": url,
                "blocked_at": datetime.utcnow().isoformat()
            })

        self.execution_log.append({"action": "block_urls", "blocked": blocked})
        return blocked

    def notify_users(self, affected_users, indicators):

        notifications = []

        for user in affected_users:
            message = f"Security Alert: Suspicious email detected. Indicators: {indicators}"
            notifications.append({
                "user": user,
                "message": message,
                "sent_at": datetime.utcnow().isoformat()
            })

        self.execution_log.append({"action": "notify_users", "notifications": notifications})
        return notifications

    def execute_playbook(self, phishing_incident):

        header_analysis = self.analyze_email_headers(phishing_incident)
        urls = self.extract_urls(phishing_incident.get("body", ""))
        url_analysis = self.analyze_urls(urls)

        malicious_urls = [u["url"] for u in url_analysis if u["malicious"]]

        quarantine_result = self.quarantine_emails({
            "sender": phishing_incident.get("sender"),
            "subject": phishing_incident.get("subject")
        })

        blocked = self.block_malicious_urls(malicious_urls)

        notifications = self.notify_users(
            phishing_incident.get("recipients", []),
            malicious_urls
        )

        summary = {
            "header_analysis": header_analysis,
            "url_analysis": url_analysis,
            "quarantine": quarantine_result,
            "blocked_urls": blocked,
            "notifications": notifications,
            "execution_log": self.execution_log
        }

        return summary


if __name__ == "__main__":

    playbook = PhishingPlaybook()

    incident = {
        "subject": "Urgent: Verify Your Account",
        "sender": "noreply@suspicious-domain.com",
        "recipients": ["user1@company.com", "user2@company.com"],
        "body": "Click here to verify: http://malicious-site.com/verify",
        "headers": {
            "received-spf": "fail",
            "dkim-signature": "",
            "authentication-results": "dmarc=fail"
        }
    }

    result = playbook.execute_playbook(incident)
    print(json.dumps(result, indent=4))
