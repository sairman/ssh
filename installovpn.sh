apt-get install open vpn -y && cp -a /usr/share/doc/openvpn/examples/easy-rsa /etc/openvpn/
cd /etc/openvpn/easy-rsa/2.0
source ./vars
./clean-all && ./build-ca && ./build-dh && ./build-key-server server01
openvpn --genkey --secret keys/ta.key
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
service openvpn restart
nano /etc/openvpn/easy-rsa/2.0/keys/ca.crt
