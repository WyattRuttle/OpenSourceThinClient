# To run the script, simply execute "sh yadgui.sh"

# Creats the GUI itself with the buttons, and field entries
  yad --no-buttons --width 500 --height 450 --no-escape --title="Select from the opitons below" \
    --form \
    --field="Remmina:BTN" 'bash -c remmina' \
    --field="X2Go:BTN" 'bash -c x2goclient' \
    --field="XPRA:BTN" 'bash -c xpra' \
    --field="Terminal:BTN" 'bash -c x-terminal-emulator' \
    --field="SSH:BTN" 'bash -c "sh sshprompt.sh"' \
    --field="Import WireGuard Config:BTN" 'bash -c " ./wgimport.sh"'
