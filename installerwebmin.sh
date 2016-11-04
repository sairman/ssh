apt-get update
apt-get upgrade -y
apt-get install nano -y
apt-get install curl -y
wget -qO- ipv4.icanhazip.com
IP=$(wget -qO- ipv4.icanhazip.com)
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 443 -p 80"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.690_all.deb && dpkg -i webmin_1.690_all.deb
apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
apt-get -f install -y
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
apt-get install -y squid3
mv squid.conf squid.conf.bak
curl https://raw.githubusercontent.com/sairman/ssh/master/squid.conf > /etc/squid3/squid.conf
sed -i "s|acl SSH dst ip/255.255.255.255|acl SSH dst $IP/255.255.255.255|" /etc/squid3/squid.conf
service webmin restart
service squid3 restart
service dropbear restart
