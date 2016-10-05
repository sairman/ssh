cd /etc/openvpn
service vpnserver stop
curl https://raw.githubusercontent.com/sairman/ssh/master/server2.conf > server2.conf
iptables -t nat -I POSTROUTING -s 10.7.0.0/24 -o eth0 -j MASQUERADE
echo "iptables -t nat -I POSTROUTING -s 10.7.0.0/24 -o eth0 -j MASQUERADE" > /etc/iptables7.conf
iptables-save > /etc/iptables7.conf
curl https://raw.githubusercontent.com/sairman/ssh/master/iptables.conf > /etc/network/if-up.d/iptables
chmod +x /etc/network/if-up.d/iptables
service openvpn restart
