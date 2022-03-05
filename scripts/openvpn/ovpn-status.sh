#!/bin/bash

testup=$(ip a)

if [[ "$testup" = *"tun0"* ]] ; then
	ovpntunstatus="OpenVPN tunnel is not active"
else
	ovpntunstatus="OpenVPN tunnel is not active"
fi

if test -f "/etc/openvpn/client/imported-config.ovpn" ; then
	confstatus="An OpenVPN config was found"
else
    confstatus="No OpenVPN config was found. Please import one to use the VPN"
fi

yad --width 500 --height 150 --on-top --center --buttons-layout="center" --text-align="center" --button=Refresh:2 --button=Ok:0 --title "OpenVPN status" \
    --text "$confstatus\n\n$ovpntunstatus"

#If user clicks the refresh button, restart the script
if [ $? = 2 ]; then
    ./openvpn/$(basename $0) && exit
fi
