#!/bin/bash

# Check current journal usage
journalctl --disk-usage

# Only keep logs from the last 2 days and limit to 500M
journalctl --vacuum-time=2h
journalctl --vacuum-size=50M

# Modify journald configuration
echo "Modifying journald configuration..."
echo "SystemMaxUse=16M" >> /etc/systemd/journald.conf
echo "ForwardToSyslog=no" >> /etc/systemd/journald.conf

# Restart systemd-journald.service
systemctl restart systemd-journald.service

# Check if journal is running properly and log files are intact
journalctl --verify

# Clean /var/log/messages
echo "Cleaning /var/log/messages..."
cat /dev/null > /var/log/messages

# Clean /var/log/syslog
echo "Cleaning /var/log/syslog..."
cat /dev/null > /var/log/syslog

# Clean /var/log/user.log
echo "Cleaning /var/log/user.log..."
cat /dev/null > /var/log/user.log

echo "Journal maintenance completed."
