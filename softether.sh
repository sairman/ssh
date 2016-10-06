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
check
exit
