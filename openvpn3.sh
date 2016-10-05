iptables -t nat -I POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE
echo "iptables -t nat -I POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE" > /etc/iptables7.conf
iptables-save > /etc/iptables7.conf
nano /etc/openvpn/server1.conf && nano /etc/openvpn/server2.conf && service openvpn restart && reboot
