#!/bin/bash
apt-get update
apt-get upgrade -y
apt-get install nano -y
apt-get install curl -y
apt-get install -y dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 443 -p 80"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
service dropbear restart
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.690_all.deb && dpkg -i webmin_1.690_all.deb
apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
apt-get -f install -y
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
service webmin restart
apt-get install -y squid3
mv squid.conf squid.conf.bak
curl https://raw.githubusercontent.com/sairman/ssh/master/squid.conf > /etc/squid3/squid.conf
sed -i "s|acl SSH dst ip/255.255.255.255|acl SSH dst $IP/255.255.255.255|" /etc/squid3/squid.conf
IP=$(wget -qO- ipv4.icanhazip.com)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt-get -y install nginx php5-fpm php5-cli
apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs openvpn vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip unrar rsyslog debsums rkhunter
apt-get -y install build-essential
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.github.com/choirulanam217/script/master/conf/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup by Sairman</pre>" > /home/vps/public_html/index.html
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf "https://raw.github.com/choirulanam217/script/master/conf/vps.conf"
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart
service nginx restart
apt-get -y install fail2ban;service fail2ban restart
chown -R www-data:www-data /home/vps/public_html
service nginx start
service php-fpm start
service fail2ban restart
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
sed -i "s|remote ip 1194|remote $IP 1194|" /etc/openvpn/clientconfig/client-udp.ovpn
sed -i "s|;http-proxy 1194|;http-proxy $IP 1194|" /etc/openvpn/clientconfig/client-udp.ovpn
echo "<ca>" >> /etc/openvpn/clientconfig/client-udp.ovpn
cat /etc/openvpn/easy-rsa/2.0/keys/ca.crt >> /etc/openvpn/clientconfig/client-udp.ovpn
echo "</ca>" >> /etc/openvpn/clientconfig/client-udp.ovpn
sed -i "s|remote ip 55|$IP 55|" /etc/openvpn/clientconfig/client-tcp.ovpn
sed -i "s|;http-proxy 55|;http-proxy $IP 55|" /etc/openvpn/clientconfig/client-tcp.ovpn
echo "<ca>" >> /etc/openvpn/clientconfig/client-tcp.ovpn
cat /etc/openvpn/easy-rsa/2.0/keys/ca.crt >> /etc/openvpn/clientconfig/client-tcp.ovpn
echo "</ca>" >> /etc/openvpn/clientconfig/client-tcp.ovpn
apt-get install zip -y
cd /etc/openvpn/clientconfig/
zip vpn.zip *
cd
mv /etc/openvpn/clientconfig/vpn.zip /home/vps/public_html/
mv /etc/openvpn/clientconfig/client-udp.ovpn /home/vps/public_html/
mv /etc/openvpn/clientconfig/client-tcp.ovpn /home/vps/public_html/
service openvpn restart
