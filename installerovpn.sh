#!/bin/bash
IP=$(wget -qO- ipv4.icanhazip.com)
apt-get install openvpn -y
cp -a /usr/share/doc/openvpn/examples/easy-rsa /etc/openvpn/
cd /etc/openvpn/easy-rsa/2.0
source ./vars
./clean-all
./build-ca
./build-dh
./build-key-server server01
openvpn –genkey –secret keys/ta.key
cd /etc/openvpn
curl https://raw.githubusercontent.com/sairman/ssh/master/server.conf > server.conf
curl https://raw.githubusercontent.com/sairman/ssh/master/server1.conf > server1.conf
mkdir /etc/openvpn/keys
cp /etc/openvpn/easy-rsa/2.0/keys/{ca.crt,server01.crt,server01.key,dh1024.pem,ta.key} /etc/openvpn/keys/
sed -i 's/#AUTOSTART="all"/AUTOSTART="all"/g' /etc/default/openvpn
/etc/init.d/openvpn restart
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sysctl -p
iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
echo "iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE" > /etc/iptables8.conf
iptables-save > /etc/iptables8.conf
curl https://raw.githubusercontent.com/sairman/ssh/master/iptables.conf > /etc/network/if-up.d/iptables
chmod +x /etc/network/if-up.d/iptables
iptables -t nat -I POSTROUTING -s 10.9.0.0/24 -o eth0 -j MASQUERADE
echo "iptables -t nat -I POSTROUTING -s 10.9.0.0/24 -o eth0 -j MASQUERADE" > /etc/iptables9.conf
iptables-save > /etc/iptables9.conf
mkdir clientconfig
cp /etc/openvpn/easy-rsa/2.0/keys/{ca.crt,ta.key}
curl https://raw.githubusercontent.com/sairman/ssh/master/client-udp.conf > /etc/openvpn/clientconfig/client-udp.ovpn
curl https://raw.githubusercontent.com/sairman/ssh/master/client-tcp.ovpn > /etc/openvpn/clientconfig/client-tcp.ovpn
sed -i "s|;http-proxy ip 80|;http-proxy $IP 80|" /etc/openvpn/clientconfig/client-udp.ovpn
sed -i "s|remote ip 1194|remote $IP 1194|" /etc/openvpn/clientconfig/client-udp.ovpn
sed -i "s|;http-proxy 1194|;http-proxy $IP 1194|" /etc/openvpn/clientconfig/client-udp.ovpn
echo "<ca>" >> /etc/openvpn/clientconfig/client-udp.ovpn
cat /etc/openvpn/easy-rsa/2.0/keys/ca.crt >> /etc/openvpn/clientconfig/client-udp.ovpn
echo "</ca>" >> /etc/openvpn/clientconfig/client-udp.ovpn
sed -i "s|;http-proxy ip 80|;http-proxy $IP 80|" /etc/openvpn/clientconfig/client-tcp.ovpn
sed -i "s|remote ip 55|$IP 55|" /etc/openvpn/clientconfig/client-tcp.ovpn
sed -i "s|;http-proxy 55|;http-proxy $IP 55|" /etc/openvpn/clientconfig/client-tcp.ovpn
echo "<ca>" >> /etc/openvpn/clientconfig/client-tcp.ovpn
cat /etc/openvpn/easy-rsa/2.0/keys/ca.crt >> /etc/openvpn/clientconfig/client-tcp.ovpn
echo "</ca>" >> /etc/openvpn/clientconfig/client-tcp.ovpn
apt-get install zip -y
cd /etc/openvpn/clientconfig/
zip VPN.zip *
cd
service openvpn restart
