#!/bin/bash
# Script auto create trial user SSH
# yg akan expired dalam hitungan menit/jam
# www.fb.com/sairman.saja
IP=$(wget -qO- ipv4.icanhazip.com)
Login=trial-`</dev/urandom tr -dc X-Z0-9 | head -c4`
Pass=`</dev/urandom tr -dc a-f0-9 | head -c10`
useradd -s /bin/false -M $Login && echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "Username: $Login"
echo -e "Password: $Pass"
echo -e "Hots/IP: $IP"
echo -e "Port: 443, 80"
echo -e "maksimal login 3 bitvise/plink"
echo -e "1 akun hanya untuk 1 user"
echo -e "Tidak boleh login lbh dr 1 pc/android atau login bersamaan antara pc dan android"
echo -e ""
sleep 1800 && skill -KILL -u $Login && userdel --force $Login && minggat | grep $Login | awk {'print$2'} | sed 's/.$//' | sed 's/^....//' > /tmp/logout && PID=`cat /tmp/logout` && kill -9 $PID &> /dev/null &
