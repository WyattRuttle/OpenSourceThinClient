input=$(
  yad --width 500 --height 200 --center --on-top --no-buttons --title "Input the following values to generate a config" \
    --form \
    --field="Interface Address:" \
    --field="Endpoint public key:" \
    --field="Endpoint IP address:" \
    --field="Endpoint port:" \
    --field="Routes separated with commas:"
)
privatekey=$(cat /etc/wireguard/privatekey)
intaddress=$(echo $input | awk -F "|" '{ print $1 }')
pubkey=$(echo $input | awk -F "|" '{ print $2 }')
endip=$(echo $input | awk -F "|" '{ print $3 }')
endport=$(echo $input | awk -F "|" '{ print $4 }')
routes=$(echo $input | awk -F "|" '{ print $5 }')

echo "[Interface]\nPrivateKey = ${privatekey}\nAddress = ${intaddress}\n[Peer]\nPublicKey = ${pubkey}\nEndPoint = ${endip}:${endport}\nAllowedIPs = ${routes}" > /etc/wireguard/wg0.conf
