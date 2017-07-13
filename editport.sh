sed -i "s|DROPBEAR_EXTRA_ARGS="-p 443 -p 80"|DROPBEAR_EXTRA_ARGS="-p 443"|" /etc/default/dropbear
sed -i "s|port 55|port 80|" /etc/openvpn/server1.conf
wget -qO- ipv4.icanhazip.com
IP=$(wget -qO- ipv4.icanhazip.com)
curl https://raw.githubusercontent.com/sairman/ssh/master/eovpntsel.ovpn > /home/vps/public_html/eovpntsel.ovpn
sed -i "s|remote ip 80|remote $IP 80|" /home/vps/public_html/eovpntsel.ovpn
echo "<ca>" >> /home/vps/public_html/eovpntsel.ovpn
cat /etc/openvpn/easy-rsa/2.0/keys/ca.crt >> /home/vps/public_html/eovpntsel.ovpn
echo "</ca>" >> /home/vps/public_html/eovpntsel.ovpn
service dropbear restart
service openvpn restart
