#!/bin/bash

tunnel=$(ip a)

if test -f "/etc/wireguard/wg0.conf" ; then
    confstatus="A Wireguard config was found"
else
    confstatus="No Wireguard configs were found. Please import or generate one to use Wireguard"
fi

if [[ "$tunnel" = *"wg0"* ]] ; then
    tunnelstatus="Wireguard VPN tunnel is active"
else
    tunnelstatus="Wireguard VPN tunnel is not active"
fi

yad --width 500 --height 150 --on-top --center --buttons-layout="center" --text-align="center" --button=Referesh:2 --button=Ok:0 --title "Wireguard status" \
    --text "$confstatus\n\n$tunnelstatus"

#If user clicks the refresh button, restart the script
if [ $? = 2 ]; then
    ./wireguard/$(basename $0) && exit
fi
