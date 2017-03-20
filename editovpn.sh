wget -qO- ipv4.icanhazip.com
IP=$(wget -qO- ipv4.icanhazip.com)
curl https://raw.githubusercontent.com/sairman/ssh/master/client-b7.ovpn > /etc/openvpn/clientconfig/client-b7.ovpn
curl https://raw.githubusercontent.com/sairman/ssh/master/client-b8.ovpn > /etc/openvpn/clientconfig/client-b8.ovpn
sed -i "s|remote ip 55|remote $IP 55|" /etc/openvpn/clientconfig/client-b7.ovpn
sed -i "s|http-proxy ip 3128|http-proxy $IP 3128|" /etc/openvpn/clientconfig/client-b7.ovpn
sed -i "s|route ip 255.255.255.255|route $IP 255.255.255.255|" /etc/openvpn/clientconfig/client-b7.ovpn
echo "<ca>" >> /etc/openvpn/clientconfig/client-b7.ovpn
cat /etc/openvpn/easy-rsa/2.0/keys/ca.crt >> /etc/openvpn/clientconfig/client-b7.ovpn
echo "</ca>" >> /etc/openvpn/clientconfig/client-b7.ovpn
sed -i "s|remote ip 55|remote $IP 55|" /etc/openvpn/clientconfig/client-b8.ovpn
sed -i "s|http-proxy ip 3128|http-proxy $IP 3128|" /etc/openvpn/clientconfig/client-b8.ovpn
sed -i "s|route ip 255.255.255.255|route $IP 255.255.255.255|" /etc/openvpn/clientconfig/client-b8.ovpn
echo "<ca>" >> /etc/openvpn/clientconfig/client-b8.ovpn
cat /etc/openvpn/easy-rsa/2.0/keys/ca.crt >> /etc/openvpn/clientconfig/client-b8.ovpn
echo "</ca>" >> /etc/openvpn/clientconfig/client-b8.ovpn
cp /etc/openvpn/clientconfig/client-b7.ovpn /home/vps/public_html
cp /etc/openvpn/clientconfig/client-b8.ovpn /home/vps/public_html
service openvpn restart
