#!/bin/bash
# Script auto create trial user SSH
# yg akan expired dalam hitungan menit/jam
# www.fb.com/sairman.saja
Login=trial-`</dev/urandom tr -dc X-Z0-9 | head -c4`
Pass=`</dev/urandom tr -dc a-f0-9 | head -c10`
IP=`ifconfig eth0:0| awk 'NR==2 {print $2}'| awk -F: '{print $2}'`
useradd -s /bin/false -M $Login && echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e "User: $Login Password: $Pass\nIP: $IP Port: 443, 80"
sleep 1800 && skill -KILL -u $Login && userdel --force $Login && minggat | grep $Login | awk {'print$2'} | sed 's/.$//' | sed 's/^....//' > /tmp/logout && PID=`cat /tmp/logout` && kill -9 $PID &> /dev/null &
