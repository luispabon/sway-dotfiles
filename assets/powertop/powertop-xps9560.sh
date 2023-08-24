#!/bin/bash
powertop --auto-tune

# Disable power saving for logitech & microsoft input receivers
echo 'on' > '/sys/bus/usb/devices/3-1.3/power/control';
echo 'on' > '/sys/bus/usb/devices/3-1.4/power/control';
