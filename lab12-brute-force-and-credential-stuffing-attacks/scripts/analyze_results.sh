#!/bin/bash
# Attack Results Analyzer (Completed)

RESULTS_FILE=$1
REPORT_FILE="analysis_report.html"

if [ $# -ne 1 ]; then
    echo "Usage: $0 <results_file>"
    exit 1
fi

if [ ! -f "$RESULTS_FILE" ]; then
    echo "Results file not found!"
    exit 1
fi

count_successes() {
    grep -c "login:" "$RESULTS_FILE"
}

extract_accounts() {
    grep "login:" "$RESULTS_FILE" | awk '{print $5 ":" $7}'
}

analyze_passwords() {
    grep "login:" "$RESULTS_FILE" | awk '{print $7}' | while read password; do
        length=${#password}
        if [ "$length" -lt 6 ]; then
            echo "$password (Very Weak)"
        elif [[ "$password" =~ ^[0-9]+$ ]]; then
            echo "$password (Numeric Only)"
        elif [[ "$password" =~ ^[a-zA-Z]+$ ]]; then
            echo "$password (Alphabet Only)"
        else
            echo "$password (Moderate)"
        fi
    done
}

generate_report() {

SUCCESS_COUNT=$(count_successes)

cat > "$REPORT_FILE" << EOF
<!DOCTYPE html>
<html>
<head>
<title>Security Assessment Report</title>
<style>
body { font-family: Arial; margin: 40px; }
h1 { color: #c0392b; }
table { border-collapse: collapse; width: 100%; }
th, td { border: 1px solid black; padding: 8px; }
</style>
</head>
<body>

<h1>Security Assessment Report</h1>

<h2>Summary</h2>
<p>Total Successful Logins: $SUCCESS_COUNT</p>

<h2>Compromised Accounts</h2>
<pre>
$(extract_accounts)
</pre>

<h2>Password Strength Analysis</h2>
<pre>
$(analyze_passwords)
</pre>

<h2>Recommendations</h2>
<ul>
<li>Enforce strong password policy</li>
<li>Enable account lockout mechanisms</li>
<li>Implement Multi-Factor Authentication (MFA)</li>
<li>Deploy intrusion prevention systems</li>
</ul>

</body>
</html>
EOF

echo "Report generated: $REPORT_FILE"
}

generate_report
