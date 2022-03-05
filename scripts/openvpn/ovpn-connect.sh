#!/bin/bash

if test -f "/etc/openvpn/client/imported-config.ovpn" ; then
	vpncreds=$(yad --width 350 --height 150 --center --on-top --no-buttons --title "Input VPN Credentials" \
    --text "Please input your OpenVPN user credentials below, then click enter." \
    --form \
    --field="Username:" \
    --field="Password:":H
	)

	retVal=$?

	if [ $retVal != 0 ]; then
    	exit 1
	else
		vpnuname=$(echo $vpncreds | awk -F "|" '{ print $1 }')
		vpnpass=$(echo $vpncreds | awk -F "|" '{ print $2 }')
		printf "$vpnuname\n$vpnpass" > /tmp/vpnauth.txt

		openvpn --config /etc/openvpn/client/imported-config.ovpn --auth-user-pass /tmp/vpnauth.txt --daemon
		sleep 3
		testup=$(ip a)
		if [[ "$testup" = *"tun0"* ]] ; then
			yad --width 300 --height 100 --on-top --center --button=Ok:0 --title "VPN connection created" \
		    --text "VPN has sucessfully connected."
		else
			yad --width 300 --height 100 --on-top --center --button=Ok:1 --title "VPN connection failed" \
		    --text "VPN failed to connect. If this error persists check the OpenVPN logs or contact your system administrator."
		fi
	fi
    
else
    yad --width 300 --height 100 --on-top --button=Ok:1 --center --title "No OpenVPN config is available" \
    --text "No OpenVPN configuration file was found, please import one before attempting to connect."

fi
rm /tmp/vpnauth.txt
