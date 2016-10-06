ifconfig tap_soft
apt-get install dnsmasq -y
curl https://raw.githubusercontent.com/sairman/ssh/master/dsnmasq.conf > /etc/dnsmasq.conf
curl https://raw.githubusercontent.com/sairman/ssh/master/vpnserver2.conf > /etc/init.d/vpnserver
sysctl -n -e system
cd /usr/local/vpnserver
iptables -t nat -A POSTROUTING -s 192.168.7.0/24 -j SNAT --to-source 128.199.98.18
echo "iptables -t nat -A POSTROUTING -s 192.168.7.0/24 -j SNAT --to-source 128.199.98.18" > /etc/iptables10.conf
iptables -t nat -L
/etc/init.d/vpnserver restart
/etc/init.d/dnsmasq restart
reboot
