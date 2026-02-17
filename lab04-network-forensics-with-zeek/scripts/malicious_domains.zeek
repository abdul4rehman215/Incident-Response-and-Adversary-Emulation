@load base/protocols/dns
@load base/protocols/http

module MaliciousDomains;

export {
    const suspicious_domains: set[string] = {
        "malware-example.com",
        "phishing-site.net",
        "suspicious-domain.org",
        "bad-actor.com"
    };
}

event dns_request(c: connection, msg: dns_msg, query: string, qtype: count, qclass: count)
{
    if (query in suspicious_domains)
    {
        print fmt("ALERT: DNS query to suspicious domain %s from %s", query, c$id$orig_h);
        print fmt("%s,%s,DNS_SUSPICIOUS,%s",
            strftime("%Y-%m-%d %H:%M:%S", network_time()),
            c$id$orig_h,
            query) >> "malicious_activity.log";
    }
}

event http_request(c: connection, method: string, original_URI: string,
                   unescaped_URI: string, version: string)
{
    if (c$id$resp_h in suspicious_domains)
    {
        print fmt("ALERT: HTTP request to suspicious domain %s from %s",
            c$id$resp_h, c$id$orig_h);

        print fmt("%s,%s,HTTP_SUSPICIOUS,%s%s",
            strftime("%Y-%m-%d %H:%M:%S", network_time()),
            c$id$orig_h,
            c$id$resp_h,
            original_URI) >> "malicious_activity.log";
    }
}
