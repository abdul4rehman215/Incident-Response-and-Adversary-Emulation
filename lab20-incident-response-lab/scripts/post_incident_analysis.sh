#!/bin/bash

echo "=== POST-INCIDENT ANALYSIS ==="

BASE_DIR=~/incident-response-lab
REPORT_DIR=$BASE_DIR/reports

mkdir -p $REPORT_DIR

# Generate Incident Timeline
cat > $REPORT_DIR/incident_timeline.txt << 'TIMELINE_EOF'
INCIDENT RESPONSE TIMELINE
==========================

T+00:00 - Initial attack simulation launched
T+00:05 - Port scanning detected by Suricata
T+00:10 - Web attacks detected by Wazuh
T+00:15 - Malware behavior detected by multiple tools
T+00:20 - Incident classified as HIGH severity
T+00:25 - Containment procedures initiated
T+00:30 - Network isolation implemented
T+00:35 - Malicious processes terminated
T+00:40 - Eradication procedures started
T+00:45 - System patching completed
T+00:50 - Recovery procedures initiated
T+00:55 - Services restored and verified
T+01:00 - Post-incident analysis begun
TIMELINE_EOF

# Generate Lessons Learned Report
cat > $REPORT_DIR/lessons_learned.txt << 'LESSONS_EOF'
LESSONS LEARNED REPORT
======================

WHAT WENT WELL:
- Detection tools identified multiple attack vectors
- Incident response playbook followed systematically
- Containment implemented quickly
- Evidence properly collected
- Recovery restored normal operations

AREAS FOR IMPROVEMENT:
- Faster alert triage needed
- Improve tool integration
- Automate containment for known threats
- Improve backup strategy
- Conduct more frequent training

RECOMMENDATIONS:
1. Implement SOAR platform
2. Enhance network segmentation
3. Improve user security awareness training
4. Conduct regular penetration testing
5. Update IR procedures quarterly

TECHNICAL IMPROVEMENTS:
- Real-time alerting
- Threat intelligence integration
- Additional monitoring sensors
- Improved log correlation
- Automated threat hunting
LESSONS_EOF

# Generate Executive Summary
cat > $REPORT_DIR/executive_summary.txt << 'EXEC_EOF'
EXECUTIVE INCIDENT SUMMARY
==========================

INCIDENT OVERVIEW:
A simulated multi-vector cyber attack was detected, contained,
and remediated using open-source security tools.

KEY METRICS:
- Time to Detection: 5 minutes
- Time to Containment: 25 minutes
- Time to Recovery: 55 minutes
- Total Duration: 1 hour
- Systems Affected: 1 (Web Server)
- Data Compromised: None (simulation)

BUSINESS IMPACT:
- No real disruption (lab environment)
- Validated security controls
- Identified improvement areas

FINANCIAL IMPACT:
- Minimal response cost
- Significant breach cost avoided
- Positive ROI on security investment

NEXT STEPS:
1. Implement security improvements
2. Conduct regular training
3. Update policies
4. Schedule follow-up assessment
EXEC_EOF

echo "Post-incident analysis reports generated"
echo "Reports available in: $REPORT_DIR"
ls -la $REPORT_DIR
