# 🛠 Troubleshooting Guide - Lab 11: Password Cracking with Hashcat

---

## Issue 1️⃣: OpenCL Device Not Found

### Problem
Hashcat does not detect GPU or shows no OpenCL devices.

### Solution

Check OpenCL:
```

clinfo

```

Install OpenCL:
```

sudo apt install clinfo ocl-icd-opencl-dev

```

For NVIDIA:
```

sudo apt install nvidia-opencl-dev

```

Verify:
```

hashcat -I

```

---

## Issue 2️⃣: Hashcat Not Recognizing GPU

### Problem
GPU installed but Hashcat uses CPU only.

### Solution

Check GPU status:
```

nvidia-smi

```

Check drivers:
```

lspci | grep -i vga

```

Reinstall driver if needed:
```

sudo apt purge nvidia-*
sudo apt autoremove
sudo apt install nvidia-driver-470

```

Reboot system.

---

## Issue 3️⃣: Slow Cracking Performance

### Causes
- Using CPU instead of GPU
- Low workload profile
- Thermal throttling

### Solutions

Increase workload:
```

--workload-profile 3

```

Enable optimized kernel:
```

--optimized-kernel-enable

```

Monitor GPU:
```

nvidia-smi

```

Check temperature:
```

sensors

```

---

## Issue 4️⃣: Hashcat Cracks Nothing

### Possible Causes
- Wrong hash mode
- Incorrect hash format
- Wordlist missing correct password

### Fix

Identify hash type:
```

hashcat --example-hashes

```

Verify mode:
- MD5 → -m 0
- SHA-256 → -m 1400
- NTLM → -m 1000
- bcrypt → -m 3200

Check file formatting:
- No extra spaces
- One hash per line

---

## Issue 5️⃣: Permission Errors

Run with proper permissions:
```

sudo hashcat ...

```

Ensure hash files readable:
```

chmod 644 md5_hashes.txt

```

---

## Issue 6️⃣: GPU Overheating

Monitor:
```

nvidia-smi

```

Reduce workload:
```

--workload-profile 2

```

Ensure proper cooling.

---

## Issue 7️⃣: Benchmark Freezes

Reduce workload profile:
```

hashcat -b --workload-profile 2

```

Close background GPU processes.

---

## Security & Ethical Considerations

✔ Only crack hashes in authorized environments  
✔ Never attack production systems without written permission  
✔ Respect legal boundaries  
✔ Document findings responsibly  
✔ Follow responsible disclosure procedures  

---

## 🏁 Final Troubleshooting Summary

All lab components validated:

✔ Hashcat installation  
✔ OpenCL GPU detection  
✔ MD5 cracking  
✔ SHA-256 cracking  
✔ Brute force attack  
✔ Rule-based attack  
✔ Combination attack  
✔ Benchmarking  
✔ Performance comparison  
