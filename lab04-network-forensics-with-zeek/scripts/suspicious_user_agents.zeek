@load base/protocols/http

module SuspiciousUserAgents;

export {
    const suspicious_patterns: set[string] = {
        "sqlmap",
        "nikto",
        "nmap",
        "masscan",
        "python-requests",
        "bot",
        "crawler",
        "scanner"
    };
}

event http_header(c: connection, is_orig: bool, name: string, value: string)
{
    if (is_orig && to_lower(name) == "user-agent")
    {
        local ua = to_lower(value);

        for (pattern in suspicious_patterns)
        {
            if (pattern in ua)
            {
                print fmt("ALERT: Suspicious User-Agent detected: %s from %s",
                          value, c$id$orig_h);

                print fmt("%s,%s,SUSPICIOUS_USER_AGENT,%s",
                          strftime("%Y-%m-%d %H:%M:%S", network_time()),
                          c$id$orig_h,
                          value) >> "malicious_activity.log";

                break;
            }
        }
    }
}
