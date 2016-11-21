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
curl https://raw.githubusercontent.com/sairman/ssh/master/installerovpn.sh > 2.sh
chmod +x 2.sh
./2.sh
apt-get install build-essential -y
wget http://www.softether-download.com/files/softether/v4.08-9449-rtm-2014.06.08-tree/Linux/SoftEther%20VPN%20Server/32bit%20-%20Intel%20x86/softether-vpnserver-v4.08-9449-rtm-2014.06.08-linux-x86-32bit.tar.gz
tar zxvf softether-vpnserver-v4.08-9449-rtm-2014.06.08-linux-x86-32bit.tar.gz
cd vpnserver
make
cd ..
mv vpnserver /usr/local
cd /usr/local/vpnserver/
chmod 600 *
chmod 700 vpncmd
chmod 700 vpnserver
curl https://raw.githubusercontent.com/sairman/ssh/master/vpnserver.conf > /etc/init.d/vpnserver
chmod 755 /etc/init.d/vpnserver
mkdir /var/lock/subsys
update-rc.d vpnserver defaults
/etc/init.d/vpnserver start
cd /usr/local/vpnserver/
./vpncmd
service nginx start
service php-fpm start
service fail2ban restart
service webmin restart
service squid3 restart
service dropbear restart
service openvpn restart
service vpnserver restart
cp /etc/openvpn/clientconfig/client-udp.ovpn /home/vps/public_html
cp /etc/openvpn/clientconfig/client-tcp.ovpn /home/vps/public_html
echo "0 */12 * * * root /sbin/reboot" > /etc/cron.d/reboot
service cron restart
cd /usr/bin
curl https://raw.githubusercontent.com/sairman/ssh/master/buat > buat
curl https://raw.githubusercontent.com/sairman/ssh/master/gusur > gusur
curl https://raw.githubusercontent.com/sairman/ssh/master/siapa > siapa
curl https://raw.githubusercontent.com/sairman/ssh/master/trial > trial
curl https://raw.githubusercontent.com/sairman/ssh/master/minggat > minggat
curl https://raw.githubusercontent.com/sairman/ssh/master/renew > renew
curl https://raw.githubusercontent.com/sairman/ssh/master/akun > akun
curl https://raw.githubusercontent.com/sairman/ssh/master/fitur > fitur
chmod +x buat
chmod +x gusur
chmod +x siapa
chmod +x trial
chmod +x minggat
chmod +x renew
chmod +x akun
chmod +x fitur
cd
cp vpn.zip /home/vps/public_html
cd /home/vps/public_html
unzip vpn.zip
cd
apt-get install mysql-server -y
mysql_secure_installation
chown -R mysql:mysql /var/lib/mysql/
chmod -R 755 /var/lib/mysql/
apt-get install nginx php5 php5-fpm php5-cli php5-mysql php5-mcrypt
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old
curl https://raw.githubusercontent.com/sairman/conf/master/nginx.conf > /etc/nginx/nginx.conf
curl https://raw.githubusercontent.com/sairman/conf/master/vps.conf > /etc/nginx/conf.d/vps.conf
sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php5/fpm/php.ini
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
useradd -m vps
mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
chown -R www-data:www-data /home/vps/public_html
chmod -R g+rw /home/vps/public_html
service php5-fpm restart
service nginx restart
apt-get install git -y
cd /home/vps/public_html
git init
git remote add origin https://github.com/sairman/ocs-panel.git
git pull origin master
mysql -u root -p
CREATE DATABASE IF NOT EXISTS OCS_PANEL;EXIT;
chmod 777 /home/vps/public_html/config
chmod 777 /home/vps/public_html/config/config.ini
chmod 777 /home/vps/public_html/config/route.ini
rm -R /home/vps/public_html/installation
