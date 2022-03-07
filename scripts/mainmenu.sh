# To run the script, simply execute "sh yadgui.sh"

# Creats the GUI itself with the buttons, and field entries
yad --fullscreen --undecorated --no-buttons --title="Select from the opitons below" \
  --form \
  --field="Remmina:BTN" 'bash -c remmina' \
  --field="X2Go:BTN" 'bash -c x2goclient' \
  --field="XPRA:BTN" 'bash -c xpra' \
  --field="Terminal:BTN" 'bash -c x-terminal-emulator' \
  --field="SSH:BTN" 'bash -c "sh sshprompt.sh"' \
  --field="WireGuard:BTN" 'bash -c "./wireguard/wg-main.sh"' \
  --field="OpenVPN:BTN" 'bash -c "./openvpn/ovpn-main.sh"'
