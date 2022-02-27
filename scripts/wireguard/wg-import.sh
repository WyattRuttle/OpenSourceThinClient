outfile=$(yad --width 600 --height 400 --on-top --center --no-escape --file --title="Select the config you would like to import")

retVal=$?
if [ $retVal != 0 ]; then
    exit 1
else
    cp $outfile "/etc/wireguard/wg0.conf"
    if test -f "/etc/wireguard/wg0.conf" ; then
        yad --width 300 --height 100 --on-top --center --title "Successfully Imported" \
        --text "WireGuard config was sucessfully imported"
    else
        yad --width 300 --height 100 --on-top --center --title "Failed to import config" \
        --text "WireGuard config failed to import. There may be an issue with the permissions of your Wireguard directory."
    fi
fi
