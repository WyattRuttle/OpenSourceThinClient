#!/bin/bash
creds=$(yad --width 350 --height 150 --center --on-top --no-buttons --title "Input Admin Credentials" \
    --text "The following action requires Administrative access. Please input the credentials of your account below, then click enter." \
    --form \
    --field="Username:" \
    --field="Password:":H
)
#Gets username and password from the prompt and assigns them to variables
uname=$(echo $creds | awk -F "|" '{ print $1 }')
pass=$(echo $creds | awk -F "|" '{ print $2 }')
isadmin=$(id "$uname")

if [ $? -ne 0 ]; then
    yad --width 450 --height 100 --on-top --center --buttons-layout="center" --button=OK:1 --title "Provided user does not exsist" \
        --text "The user provided does not exsist. Please input a valid username and password"
    exit 1


elif [[ "$isadmin" = *"27(sudo)"* ]] || [[ "$isadmin" = *"uid=0(root)"* ]] ; then
    yad --no-buttons --width 500 --height 300 --no-escape --on-top --title="What would you like to do with OpenVPN?" \
      --form \
      --field="Import existing OpenVPN config:BTN" 'bash -c "echo '${pass}' | sudo -S sh openvpn/ovpn-import.sh"' \
      --field="Enable OpenVPN connection:BTN" 'bash -c "sudo -K | echo '${pass}' | sudo -S bash openvpn/ovpn-connect.sh"' \
      --field="Disable OpenVPN connection:BTN" 'bash -c "echo '${pass}' | sudo -S killall openvpn"' \
      --field="Check OpenVPN status:BTN" 'bash -c "echo '${pass}' | sudo -S bash openvpn/ovpn-status.sh"'

else
    yad --width 450 --height 100 --on-top --center --buttons-layout="center" --button=OK:1 --title "Provided user is not an administrator" \
    --text "The user provided does not have administrative access. Please add the user to the sudo group, or contact your system administrator."

fi
