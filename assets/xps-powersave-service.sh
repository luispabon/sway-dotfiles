#!/bin/bash

# Touch screen
echo 'auto' > '/sys/bus/usb/devices/1-9/power/control'

# PCI
echo 'auto' > '/sys/bus/pci/devices/0000:00:1c.1/power/control'
echo 'auto' > '/sys/bus/pci/devices/0000:00:1d.6/power/control'

# SATA
echo 'auto' > '/sys/bus/pci/devices/0000:00:17.0/ata1/power/control'
echo 'auto' > '/sys/bus/pci/devices/0000:00:17.0/ata2/power/control'

# SATA link
echo 'min_power' > '/sys/class/scsi_host/host0/link_power_management_policy'
echo 'min_power' > '/sys/class/scsi_host/host1/link_power_management_policy'
