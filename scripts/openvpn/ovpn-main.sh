#!/bin/bash
creds=$(yad --width 350 --height 100 --undecorated --center --on-top --buttons-layout="center" --button=Cancel:3 --title "Input Admin Credentials" \
    --text "The following action requires Administrative access. Please input the credentials of your account below, then click enter." \
    --form \
    --field="Password:":H
)
canceloption=$?
#Gets username and password from the prompt and assigns them to variables
uname=$(whoami)
pass=$(echo $creds | awk -F "|" '{ print $1 }')
isadmin=$(id "$uname")

if [ $canceloption -eq 3 ]; then
	exit

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
