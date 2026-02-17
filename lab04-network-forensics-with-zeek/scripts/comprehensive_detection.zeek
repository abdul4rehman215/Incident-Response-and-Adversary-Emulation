@load base/protocols/conn
@load base/protocols/dns
@load base/protocols/http

@load ./malicious_domains.zeek
@load ./port_scan_detector.zeek
@load ./suspicious_user_agents.zeek

event zeek_init()
{
    print "Comprehensive Network Security Monitoring Started";
    print "- Monitoring malicious domains";
    print "- Monitoring port scans";
    print "- Monitoring suspicious user agents";
}

event connection_state_remove(c: connection)
{
    if (c?$duration && c$duration > 3600sec)
    {
        print fmt("ALERT: Long-duration connection %s -> %s:%d",
                  c$id$orig_h, c$id$resp_h, c$id$resp_p);

        print fmt("%s,%s,LONG_CONNECTION,%s:%d",
                  strftime("%Y-%m-%d %H:%M:%S", network_time()),
                  c$id$orig_h,
                  c$id$resp_h,
                  c$id$resp_p) >> "malicious_activity.log";
    }

    if (c?$orig_bytes && c$orig_bytes > 100000000)
    {
        print fmt("ALERT: High data transfer %s -> %s:%d (%d bytes)",
                  c$id$orig_h, c$id$resp_h, c$id$resp_p, c$orig_bytes);

        print fmt("%s,%s,HIGH_DATA_TRANSFER,%d_bytes",
                  strftime("%Y-%m-%d %H:%M:%S", network_time()),
                  c$id$orig_h,
                  c$orig_bytes) >> "malicious_activity.log";
    }
}
