@echo off
echo "Usage: VPNIP"
echo "Probably: %0 1.2.3.4"

set LOCALIP=192.168.56.253

if not "%2" == "" (
    set LOCALIP="%2"
)

rem Assign static IP.
netsh interface ip set address name="Local Area Connection" ^
    static %LOCALIP% 255.255.255.0 192.168.56.1 1

rem Delete all routes to 0.0.0.0/32.
route delete 0.0.0.0

rem By default route the internet to something that doesn't exist.
route add 0.0.0.0 mask 0.0.0.0 192.168.56.254 metric 2

rem Route the VPN IP address to the internet.
if not "%1" == "" (
    route add %1 mask 255.255.255.255 192.168.56.1 metric 1
)
