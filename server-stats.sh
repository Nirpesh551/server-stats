#!/usr/bin/env bash

echo "=== Server Performance Stats ==="
echo

# Total CPU Usage
echo "Total CPU Usage:"
cpu_usage=$(mpstat 1 1 | awk '/Average/ {print 100 - $NF}')
echo "$cpu_usage% used"
echo

# Total Memory Usage
echo "Total Memory Usage:"
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_free=$(free -m | awk '/Mem:/ {print $4}')
mem_percent=$(echo "scale=2; $mem_used * 100 / $mem_total" | bc)
echo "Total: ${mem_total}MB, Used: ${mem_used}MB, Free: ${mem_free}MB ($mem_percent% used)"
echo

# Total Disk Usage
echo "Total Disk Usage:"
disk_total=$(df -h / | awk 'NR==2 {print $2}')
disk_used=$(df -h / | awk 'NR==2 {print $3}')
disk_free=$(df -h / | awk 'NR==2 {print $4}')
disk_percent=$(df -h / | awk 'NR==2 {print $5}')
echo "Total: $disk_total, Used: $disk_used, Free: $disk_free ($disk_percent used)"
echo

# Top 5 Processes by CPU Usage
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 | tail -n 5
echo

# Top 5 Processes by Memory Usage
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6 | tail -n 5
echo

# OS Version & Kernel
echo "OS Version: $(lsb_release -d | awk -F'\t' '{print $2}')"
echo "Kernel Version: $(uname -r)"
echo

# Uptime & Load Average
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo

# Logged-in Users
echo "Logged-in Users: $(who | wc -l)"
echo

