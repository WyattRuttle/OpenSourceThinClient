# To run the script, simply execute "sh yadgui.sh"

# Creats the GUI itself with the buttons, and field entries
output=$(yad --width 300 --height 300 --no-escape --title "Select from the opitons below" \
  --buttons-layout="start" \
  --button=Remmina:"bash -c remmina" \
  --button=X2Go:"bash -c x2goclient" \
  --button=XPRA:"bash -c xpra" \
  --button=Terminal:"bash -c x-terminal-emulator" \
  --form \
    --field="Input SSH Target IP:" \
    --field="Input SSH Username:"
)
# Gets the ssh IP output and assigns it to the sship variable
sship=$(echo $output | awk -F "|" '{ print $1 }')

# Gets the ssh username output and assigns it to the sshuser variable
sshuser=$(echo $output | awk -F "|" '{ print $2 }')

# Opens a new terminal window and automatically runs SSH using the provided username and IP address
konsole -e ssh $sshuser@$sship

# Reopens the GUI after the user exits SSH
sh /home/user/Desktop/yadtest.sh

# In the coming weeks, SSH will be its own button and will open a new GUI window with the two fields to input username and IP
