@load base/protocols/conn

module PortScanDetector;

export {
    const PORT_SCAN_THRESHOLD: count = 10;
    const TIME_WINDOW: interval = 60sec;
}

global port_tracker: table[addr] of set[port] &create_expire=TIME_WINDOW;

event connection_state_remove(c: connection)
{
    local src = c$id$orig_h;
    local dst_port = c$id$resp_p;

    if (src !in port_tracker)
        port_tracker[src] = set();

    add port_tracker[src][dst_port];

    if (|port_tracker[src]| >= PORT_SCAN_THRESHOLD)
    {
        print fmt("ALERT: Potential port scan detected from %s (%d unique ports)",
                  src, |port_tracker[src]|);

        print fmt("%s,%s,PORT_SCAN,%d_ports",
                  strftime("%Y-%m-%d %H:%M:%S", network_time()),
                  src,
                  |port_tracker[src]|) >> "malicious_activity.log";

        delete port_tracker[src];
    }
}

event zeek_init()
{
    schedule TIME_WINDOW { cleanup_old_entries() };
}

event cleanup_old_entries()
{
    clear_table(port_tracker);
    schedule TIME_WINDOW { cleanup_old_entries() };
}
