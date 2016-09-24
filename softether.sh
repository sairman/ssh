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
nano /etc/init.d/vpnserver

#!/bin/sh
### BEGIN INIT INFO
# Provides:          vpnserver
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start daemon at boot time
# Description:       Enable Softether by daemon.
### END INIT INFO
DAEMON=/usr/local/vpnserver/vpnserver
LOCK=/var/lock/subsys/vpnserver
test -x $DAEMON || exit 0
case "$1" in
start)
$DAEMON start
touch $LOCK
;;
stop)
$DAEMON stop
rm $LOCK
;;
restart)
$DAEMON stop
sleep 3
$DAEMON start
;;
*)
echo "Usage: $0 {start|stop|restart}"
exit 1
esac
exit 0

chmod 755 /etc/init.d/vpnserver
mkdir /var/lock/subsys
update-rc.d vpnserver defaults
/etc/init.d/vpnserver start
cd /usr/local/vpnserver/
./vpncmd
check
exit
