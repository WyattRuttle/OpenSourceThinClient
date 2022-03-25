#!/bin/bash

creds=$(yad --width 350 --height 100 --undecorated --buttons-layout="center" --button=Cancel:3 --center --on-top --title "Input Admin Password" \
    --text "The following action requires Administrative access. Please input your password, then click enter." \
    --form \
    --field="Password:":H
)
canceloption=$?
#Gets the input password from the prompt and assigns them to variables
uname=$(whoami)
pass=$(echo $creds | awk -F "|" '{ print $1 }')
isadmin=$(id "$uname")

if [ $canceloption -eq 3 ]; then
	exit


elif [[ "$isadmin" = *"27(sudo)"* ]] || [[ "$isadmin" = *"uid=0(root)"* ]] ; then
    yad --no-buttons --width 500 --height 300 --no-escape --on-top --title="What would you like to do with Wireguard?" \
      --form \
      --field="Import existing WireGuard config:BTN" 'bash -c "echo '${pass}' | sudo -S sh wireguard/wg-import.sh"' \
      --field="Generate a new Wireguard config:BTN" 'bash -c "sudo -K | echo '${pass}' | sudo -S sh wireguard/wg-generate.sh"' \
      --field="Enable Wireguard connection:BTN" 'bash -c "echo '${pass}' | sudo -S wg-quick up wg0"' \
      --field="Disable Wireguard connection:BTN" 'bash -c "echo '${pass}' | sudo -S wg-quick down wg0"' \
      --field="Check Wireguard status:BTN" 'bash -c "echo '${pass}' | sudo -S ./wireguard/wg-status.sh"'

else
    yad --width 450 --height 100 --on-top --center --buttons-layout="center" --button=OK:1 --title "Provided user is not an administrator" \
    --text "The user provided does not have administrative access. Please add the user to the sudo group, or contact your system administrator."

fi
