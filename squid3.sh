apt-get -y install squid3
mv squid.conf squid.conf.bak
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/sairman/ssh/master/squid.conf"
sed -i $MYIP2 /etc/squid3/squid.conf;
service squid3 restart
