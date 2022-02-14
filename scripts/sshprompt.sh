sshout=$(
  yad --width 300 --height 80 --no-buttons --no-escape --title "Connect via ssh" \
    --form \
      --field="SSH Target IP:" \
      --field="SSH Username:"
)

# Gets the ssh IP output and assigns it to the sship variable
sship=$(echo $sshout | awk -F "|" '{ print $1 }')

# Gets the ssh username output and assigns it to the sshuser variable
sshuser=$(echo $sshout | awk -F "|" '{ print $2 }')

konsole -e ssh $sshuser@$sship
