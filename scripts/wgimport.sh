outfile=$(yad --width 600 --height 400 --on-top --center --no-escape --file --title="Select the config you would like to import")
cp $outfile "/etc/wireguard/wg0.conf"
