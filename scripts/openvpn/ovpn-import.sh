#!/bin/bash
outfile=$(yad --width 600 --height 400 --on-top --center --no-escape --file --title="Select the config you would like to import")

retVal=$?
if [ $retVal != 0 ]; then
    exit 1
else
    cp $outfile "/etc/openvpn/client/imported-config.ovpn"
    if test -f "/etc/openvpn/client/imported-config.ovpn" ; then
        yad --width 300 --height 100 --on-top --center --title "Successfully Imported" \
        --text "OpenVPN config was sucessfully imported"
    else
        yad --width 300 --height 100 --on-top --center --title "Failed to import config" \
        --text "OpenVPN config failed to import. There may be a permissions issue present. If the error persists, contact your system administrator."
    fi
fi
