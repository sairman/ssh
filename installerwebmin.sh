apt-get update
apt-get upgrade -y
apt-get install nano -y
apt-get install curl -y
IP=$(wget -qO- ipv4.icanhazip.com)
echo "/bin/false" >> /etc/shells
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.690_all.deb && dpkg -i webmin_1.690_all.deb
apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
apt-get -f install -y
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
service webmin restart
