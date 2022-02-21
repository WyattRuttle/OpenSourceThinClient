sshout=$(
  yad --width 350 --height 80 --center --on-top --no-buttons --title "Connect via ssh" \
    --form \
    --field="SSH Target IP:" \
    --field="SSH Username:"
)

# Gets the ssh IP output and assigns it to the sship variable
sship=$(echo $sshout | awk -F "|" '{ print $1 }')

# Gets the ssh username output and assigns it to the sshuser variable
sshuser=$(echo $sshout | awk -F "|" '{ print $2 }')

konsole -e ssh $sshuser@$sship
