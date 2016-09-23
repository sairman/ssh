apt-get install -y openvpn

cp -a /usr/share/doc/openvpn/examples/easy-rsa /etc/openvpn/

cd /etc/openvpn/easy-rsa/2.0

source ./vars
./clean-all
./build-ca

./build-dh
./build-key-server server01

openvpn --genkey --secret keys/ta.key
cd /etc/openvpn

nano server.conf

port 1195
proto udp
dev tun
ca keys/ca.crt
cert keys/server01.crt
key keys/server01.key
dh keys/dh1024.pem
plugin /usr/lib/openvpn/openvpn-auth-pam.so login
client-cert-not-required
username-as-common-name
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1"
push "dhcp-option DNS 4.2.2.1"
push "dhcp-option DNS 4.2.2.2"
keepalive 5 30
comp-lzo
persist-key
persist-tun
status server-tcp.log
verb 3

nano server1.conf

port 53
proto tcp
dev tun
ca keys/ca.crt
cert keys/server01.crt
key keys/server01.key
dh keys/dh1024.pem
plugin /usr/lib/openvpn/openvpn-auth-pam.so login
client-cert-not-required
username-as-common-name
server 10.9.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1"
push "dhcp-option DNS 4.2.2.1"
push "dhcp-option DNS 4.2.2.2"
keepalive 5 30
comp-lzo
persist-key
persist-tun
status server-tcp.log
verb 3

mkdir /etc/openvpn/keys

cp /etc/openvpn/easy-rsa/2.0/keys/{ca.crt,server01.crt,server01.key,dh1024.pem,ta.key} /etc/openvpn/keys/

nano /etc/default/openvpn

/etc/init.d/openvpn restart

nano /etc/sysctl.conf

sysctl -p

iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE

nano /etc/iptables8.conf

iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE

iptables-save > /etc/iptables8.conf

nano /etc/network/if-up.d/iptables

#!/bin/sh
iptables-restore < /etc/iptables8.conf
iptables-restore < /etc/iptables9.conf

chmod +x /etc/network/if-up.d/iptables

iptables -t nat -I POSTROUTING -s 10.9.0.0/24 -o eth0 -j MASQUERADE

nano /etc/iptables9.conf

iptables -t nat -I POSTROUTING -s 10.9.0.0/24 -o eth0 -j MASQUERADE

iptables-save > /etc/iptables9.conf

mkdir clientconfig

cp /etc/openvpn/easy-rsa/2.0/keys/{ca.crt,ta.key} clientconfig/

cat clientconfig/ca.crt
