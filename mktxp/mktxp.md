 Using Mikrotik explorer we can send data to promthus and next visualize it with Grafana 


// WIP

Disclaimer
If you are using anything other than Raspberry Pi Zero or Zero W, please consider running 
already prepared option using 
https://github.com/akpw/mktxp-stack 
or
https://github.com/M0r13n/mikrotik_monitoring

Installation
1 Install MKTXP
We need to build it using python
git clone https://github.com/akpw/mktxp.git
cp mktxp/* /opt
cd /opt/mktxp 
python build install

Remember to modify config files with
mktxp edit 
and
mktxp edit -i
Next lets check if it works correctly
mktxp print -en 'router_name_from_config' -cc
if we get proper answer we can continue with 
creating a systemd service
Start a service

2 Install Prometheus
Download
Extract
Change configuration
Run
Create a service
Start a service

3 Install Grafana
Copy Dashboards
Restart service

Please go to you Pi address at port 3000
If you got no connection error please wait up to 5 minutes for grafana to start properly
