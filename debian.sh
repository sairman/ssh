apt-get update
apt-get upgrade -y
apt-get install nano -y
apt-get install curl -y
wget -qO- ipv4.icanhazip.com
IP=$(wget -qO- ipv4.icanhazip.com)
apt-get install dropbear -y
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 443"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
nano /etc/default/dropbear
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.690_all.deb && dpkg -i webmin_1.690_all.deb
apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
apt-get -f install -y
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
apt-get install -y squid3
mv squid.conf squid.conf.bak
curl https://raw.githubusercontent.com/sairman/ssh/master/squid.conf > /etc/squid3/squid.conf
sed -i "s|acl SSH dst ip/255.255.255.255|acl SSH dst $IP/255.255.255.255|" /etc/squid3/squid.conf
nano /etc/squid3/squid.conf
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt-get -y install nginx php5-fpm php5-cli
apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs openvpn vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip unrar rsyslog debsums rkhunter
apt-get -y install build-essential
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/sairman/ssh/master/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup by Sairman</pre>" > /home/vps/public_html/index.html
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/sairman/ssh/master/vps.conf"
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart
service nginx restart
apt-get -y install fail2ban;service fail2ban restart
chown -R www-data:www-data /home/vps/public_html
curl https://raw.githubusercontent.com/sairman/ssh/master/installerovpn.sh > openvpn.sh
chmod +x openvpn.sh
./openvpn.sh
service nginx start
service php-fpm start
service fail2ban restart
service webmin restart
service squid3 restart
service dropbear restart
service openvpn restart
cp /etc/openvpn/clientconfig/client-udp.ovpn /home/vps/public_html
cp /etc/openvpn/clientconfig/client-tcp.ovpn /home/vps/public_html
echo "0 */8 * * * root /sbin/reboot" > /etc/cron.d/reboot
service cron restart
cd /usr/bin
curl https://raw.githubusercontent.com/sairman/ssh/master/cek > cek
curl https://raw.githubusercontent.com/sairman/ssh/master/trial > trial
curl https://raw.githubusercontent.com/sairman/ssh/master/fitur.sh > fitur
chmod +x cek
chmod +x trial
chmod +x fitur
cd
