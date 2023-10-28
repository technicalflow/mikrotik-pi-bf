### Mikrotik and Raspberry Pi Zero Best Friends 🙂

I made sample script to connect Pi Zero using USB interface as network to Mikrotik device

Tutorial is based on Rasbian OS Lite - Debian 12 - 10.10.2023

<u>Remember to connect USB cable into 'middle' USB port in Pi Zero</u>

### Mikrotik configuration
Only after lte1 device appear in /interfaces/print <br>
I have set 192.168.51.1/24 for lte1 interface (Pi has 192.168.51.10) <br>
/ip address add address=192.168.51.1/24 interface=lte1 network=192.168.51.0

<i>Set NAT on Mikrotik - <b>not required </b><br>
/ip firewall nat add action=masquerade chain=srcnat comment="defconf: masquerade" out-interface=ether1 </i>

It is based on two tutorials:
https://www.reddit.com/r/pihole/comments/ef7tjy/pihole_on_pi_zero_w_mikrotik_connected_via_usb/

https://www.ctrl-alt-del.cc/2020/01/mikrotik-pi-zero-pi-hole-advertising.html
