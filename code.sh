#!/bin/bash

#Based on Rasbian OS Lite - Debian 12 - 10.10.2023
set -e 

timedatectl set-timezone Europe/Warsaw

swapoff -a
dphys-swapfile swapoff
dphys-swapfile uninstall 
systemctl stop swap.target
systemctl stop dphys-swapfile.service
systemctl disable dphys-swapfile.service
rm -rf /var/swap

apt remove -y alsa* bluez* network-manager modemmanager wpasupplicant wireless* avahi* ifupdown 
apt remove -y nfs-common ntfs-3g  linux-image-rpi-v7 linux-image-rpi-v7l linux-image-rpi-v8 linux-headers-rpi-v7 linux-headers-rpi-v7l
apt remove -y linux-image-6.1.0-rpi4-rpi-v8 linux-image-6.1.0-rpi4-rpi-v7 linux-image-6.1.0-rpi4-rpi-v7l
apt autoremove -y

# Reboot

# Turn off auto updates
systemctl disable apt-daily
systemctl disable apt-daily.timer 
systemctl disable apt-daily-upgrade.timer 
systemctl disable apt-daily-upgrade.service

systemctl daemon-reload 

### Convert Raspberry Pi into Ethernet adapter in order to connect to Mikrotik
touch /etc/modprobe.d/g_ether.conf
cat << EOFether > /etc/modprobe.d/g_ether.conf
options g_ether idVendor=0x05ac idProduct=0x1402 iProduct=Pi0 iManufacturer=Raspberry
EOFether

sed -i '$ s/$/ modules-load=dwc2,g_ether/' /boot/cmdline.txt 
echo nameserver 8.8.8.8 >> /etc/resolv.conf

modprobe dwc2 libcomposite

touch /etc/systemd/network/10-usb0.network
cat << EOFnet > /etc/systemd/network/10-usb0.network
[Match]
Name=usb0

[Network]
DHCP=no
DNS=9.9.9.9

Gateway=192.168.51.1
Address=192.168.51.10/24
EOFnet

systemctl enable --now systemd-networkd

cat << EOFnewconfig > /boot/firmware/config.txt
# Run as fast as firmware / board allows
arm_boost=1

[all]
arm_freq=1100
arm_freq_min=800
over_voltage=4
sdram_freq=500
sdram_over_voltage=2
boot_delay=1

dtoverlay=pi3-disable-bt
dtoverlay=disable-wifi
dtoverlay=dwc2

gpu_mem=16
EOFnewconfig

### Mikrotik configuration
# Only after lte1 device appear in /interfaces/print
#  I have set 192.168.51.1/24 for LTE1 interface (Pi has 192.168.51.10) 
# /ip address add address=192.168.51.1/24 interface=lte1 network=192.168.51.0

## Set NAT on Mikrotik - not required
## /ip firewall nat add action=masquerade chain=srcnat comment="defconf: masquerade" out-interface=ether1

##Blacklist
# blacklist snd_pcm
# blacklist snd_bcm2835
# blacklist cfg80211