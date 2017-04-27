wget -qO- ipv4.icanhazip.com
IP=$(wget -qO- ipv4.icanhazip.com)
curl https://raw.githubusercontent.com/sairman/ssh/master/hits-chat.ovpn > /etc/openvpn/clientconfig/hits-chat.ovpn
sed -i "s|remote ip 55|remote $IP 55|" /etc/openvpn/clientconfig/hits-chat.ovpn
sed -i "s|http-proxy ip 3128|http-proxy $IP 3128|" /etc/openvpn/clientconfig/hits-chat.ovpn
sed -i "s|route ip 255.255.255.255|route $IP 255.255.255.255|" /etc/openvpn/clientconfig/hits-chat.ovpn
echo "<ca>" >> /etc/openvpn/clientconfig/hits-chat.ovpn
cat /etc/openvpn/easy-rsa/2.0/keys/ca.crt >> /etc/openvpn/clientconfig/hits-chat.ovpn
echo "</ca>" >> /etc/openvpn/clientconfig/hits-chat.ovpn
cp /etc/openvpn/clientconfig/hits-chat.ovpn /home/vps/public_html
service openvpn restart
