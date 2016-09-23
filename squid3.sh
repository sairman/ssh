apt-get install -y squid3
mv squid.conf squid.conf.bak
curl https://raw.githubusercontent.com/sairman/ssh/master/squid.conf > /etc/squid3/squid.conf
service squid3 restart
