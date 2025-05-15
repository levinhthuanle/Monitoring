#!/bin/bash

echo "========== SERVER PERFORMANCE STATS =========="

# OS Version
echo -e "\n--- OS Version ---"
uname -a
[ -f /etc/os-release ] && cat /etc/os-release | grep PRETTY_NAME

# Uptime and Load Average
echo -e "\n--- Uptime and Load Average ---"
uptime

# Logged in users
echo -e "\n--- Currently Logged-in Users ---"
who

# Failed login attempts (last 10)
echo -e "\n--- Last 10 Failed Login Attempts ---"
lastb -n 10 2>/dev/null || echo "lastb command not available or no failed logins recorded."

# CPU Usage
echo -e "\n--- Total CPU Usage ---"
top -bn1 | grep "Cpu(s)" | awk '{printf "CPU Usage: %.2f%%\n", 100 - $8}'

# Memory Usage
echo -e "\n--- Memory Usage ---"
free -h
free | awk '/Mem/ {
    used=$3;
    total=$2;
    printf("Used: %.2f MB, Free: %.2f MB, Usage: %.2f%%\n", used/1024, (total-used)/1024, (used/total)*100)
}'

# Disk Usage
echo -e "\n--- Disk Usage (/ only) ---"
df -h / | awk 'NR==1 || NR==2'
df / | awk 'NR==2 {
    used=$3;
    total=$2;
    printf("Used: %.2f GB, Free: %.2f GB, Usage: %s\n", used/1024, ($4)/1024, $5)
}'

# Top 5 processes by CPU usage
echo -e "\n--- Top 5 Processes by CPU Usage ---"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by Memory usage
echo -e "\n--- Top 5 Processes by Memory Usage ---"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6

echo -e "\n========== END OF REPORT =========="

