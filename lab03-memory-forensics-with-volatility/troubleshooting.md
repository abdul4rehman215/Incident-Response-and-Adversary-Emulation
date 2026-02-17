# 🛠 Troubleshooting Guide – Lab 03: Memory Forensics with Volatility

---

## 1️⃣ LiME Module Compilation Fails

### Problem
LiME fails to compile due to kernel header mismatch or build errors.

### Symptoms
- `make` command throws errors
- Missing kernel headers
- Invalid module format during `insmod`

### Solution

```bash
# Check current kernel version
uname -r

# Install matching headers
sudo apt install linux-headers-$(uname -r)
````

Recompile:

```bash
make clean
make
```

If still failing, use alternative acquisition method:

```bash
sudo dd if=/proc/kcore of=memory-dump.dd bs=1M count=512
```

---

## 2️⃣ Volatility Cannot Detect Profile

### Problem

Volatility fails to identify correct OS profile.

### Symptoms

* Errors related to symbol tables
* `linux.banner` fails

### Solution (Volatility 3 auto-detection)

```bash
vol3 -f memory-dump.lime linux.pslist
```

If symbols missing:

```bash
vol3 -f memory-dump.lime --symbol-dirs /usr/lib/volatility3/symbols linux.banner
```

---

## 3️⃣ Memory Dump Too Large to Analyze

### Problem

Full memory dump (~4GB) causes slow processing or high resource usage.

### Solution

Compress dump:

```bash
gzip memory-dump.lime
vol3 -f memory-dump.lime.gz linux.pslist
```

Or create smaller test dump:

```bash
sudo dd if=/proc/kcore of=small-dump.dd bs=1M count=256
```

---

## 4️⃣ Permission Denied Errors

### Problem

Cannot load LiME or access dump files.

### Solution

```bash
sudo -v
sudo insmod lime-<kernel>.ko
sudo rmmod lime
```

Ensure correct permissions:

```bash
sudo chown toor:toor memory-dump.lime
```

---

## 5️⃣ Volatility Plugins Return Empty Results

### Problem

Plugins like `linux.netstat` or `linux.lsof` show no output.

### Possible Causes

* Memory dump incomplete
* Acquisition interrupted
* Incorrect symbol resolution

### Solution

Re-acquire memory:

```bash
sudo insmod lime-<kernel>.ko "path=/home/toor/memory-dumps/memory-dump.lime format=lime"
```

Verify file size stabilizes before removing module.

---

## 6️⃣ Strings Extraction Takes Too Long

### Problem

Running `strings memory-dump.lime` takes several minutes.

### Solution

Limit output:

```bash
strings memory-dump.lime | head -1000
```

Or filter during extraction:

```bash
strings memory-dump.lime | grep -E "(http|passwd|python)"
```

---

## 7️⃣ Kernel Module Shows as Suspicious

### Problem

`lime` appears in `linux.lsmod` results.

### Explanation

This is expected because LiME was used to acquire memory.

### Verification

Ensure no unknown modules appear:

```bash
vol3 -f memory-dump.lime linux.lsmod
```

---

## 8️⃣ Process Counts Differ (PSList vs PSTree)

### Problem

Process counts mismatch.

### Meaning

Possible hidden process (rootkit behavior).

### Verification

```bash
vol3 -f memory-dump.lime linux.pslist | wc -l
vol3 -f memory-dump.lime linux.pstree | wc -l
```

If counts differ → investigate further.

---

## 9️⃣ Network Ports Appear Suspicious

### Problem

Unexpected listening ports detected.

### Investigation

```bash
vol3 -f memory-dump.lime linux.netstat
```

Correlate with process list:

```bash
vol3 -f memory-dump.lime linux.pslist | grep <PID>
```

---

## 🔟 Archive Creation Fails

### Problem

Tar archive fails due to missing files.

### Solution

Verify directory:

```bash
ls final-results/
```

Then recreate archive:

```bash
tar -czf memory-forensics-analysis-$(date +%Y%m%d).tar.gz final-results/
```

---

# 🔐 Best Practices for Memory Forensics

* Always acquire memory before shutting down system
* Preserve original dump file (do not modify)
* Work on copies of memory dump
* Document every command executed
* Maintain chain of custody (even in lab scenarios)
* Validate integrity of collected evidence

---

# 📌 Final Note

Memory forensics can be resource-intensive and sensitive to system configuration.
Careful acquisition, correct symbol resolution, and systematic analysis are critical for reliable forensic results.
