# To run the script, simply execute "sh yadgui.sh"

# Creats the GUI itself with the buttons, and field entries
output=$(
  yad --width 300 --height 250 --no-escape --title "Select from the opitons below" \
    --button=Remmina:"bash -c remmina" \
    --button=X2Go:"bash -c x2goclient" \
    --button=XPRA:"bash -c xpra" \
    --button=Terminal:"bash -c x-terminal-emulator" \
    --button=SSH:"bash -c 'sh /home/user/Desktop/SEC-440/sshprompt.sh'" \

)

# In the coming weeks, SSH will be its own button and will open a new GUI window with the two fields to input username and IP
