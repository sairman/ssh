ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt-get -y install nginx php5-fpm php5-cli
apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs openvpn vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip unrar rsyslog debsums rkhunter
apt-get -y install build-essential
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.github.com/choirulanam217/script/master/conf/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup by Choirul Anam</pre>" > /home/vps/public_html/index.html
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
