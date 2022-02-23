#!/bin/bash

creds=$(yad --width 350 --height 150 --center --on-top --no-buttons --title "Input Admin Credentials" \
    --text "The following action requires Administrative access. Please input the credentials of an admin account below, then click enter." \
    --form \
    --field="Username:" \
    --field="Password:":H
)
# Gets username and password from the prompt and assigns them to variables
uname=$(echo $creds | awk -F "|" '{ print $1 }')
pass=$(echo $creds | awk -F "|" '{ print $2 }')
isadmin=$(id "$uname")

if [ $? -ne 0 ]; then
    yad --width 450 --height 100 --on-top --center --buttons-layout="center" --button=OK:1 --title "Provided user does not exsist" \
        --text "The user provided does not exsist. Please input a valid username and password"
    exit 1


elif [[ "$isadmin" = *"27(sudo)"* ]] || [[ "$isadmin" = *"uid=0(root)"* ]] ; then
        
    outfile=$(yad --width 600 --height 400 --on-top --center --file --title="Select the config you would like to import")

    retVal=$?
    if [ $retVal -ne 0 ]; then
        exit 1
    else
        cp $outfile "/etc/wireguard/wg0.conf"
        if [ test -f "/etc/wireguard/wg0.conf" ]; then
            yad --width 300 --height 100 --on-top --center --title "Successfully Imported" \
            --text "WireGuard config was sucessfully imported"
    else
        yad --width 300 --height 100 --on-top --center --title "Failed to import config" \
        --text "WireGuard config failed to import. There may be an issue with the permissions of your Wireguard directory."
        fi
    fi

else
    yad --width 450 --height 100 --on-top --center --buttons-layout="center" --button=OK:1 --title "Provided user is not an administrator" \
    --text "The user provided does not have administrative access. Please add the user to the sudo group, or contact your system administrator."

fi

