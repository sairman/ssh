#!/bin/bash
# www.fb.com/sairman.saja
# 085298350285
ps ax | grep dropbear > /tmp/PID.txt
cat /var/log/auth.log |  grep -i "Password auth succeeded" | awk '{print $10,"\t","\t",$12,"\t","\t",$3,$2,$1,"\t",$5;}' | sed s/.$// | column -t | sed "s/'//g" > /tmp/konek.txt
perl -pi -e 's/dropbear/PID/g' /tmp/konek.txt

echo "----------------------------------------------------------------" > /tmp/siapa.txt
echo "[USER]      [KONEK VIA]          [LOGIN SEJAK]*      [INFO]" >> /tmp/siapa.txt
echo "----------------------------------------------------------------" >> /tmp/siapa.txt
cat /tmp/PID.txt | while read line;do
set -- $line
cat /tmp/konek.txt | grep $1 >> /tmp/siapa.txt
done
echo " " >> /tmp/siapa.txt
echo "Ingin tendang user? Ketik kill -9 (angka PID)" >> /tmp/siapa.txt
echo "Misal: kill -9 1234 [enter]" >> /tmp/siapa.txt
echo "----------------------------------------------------------------" >> /tmp/siapa.txt
echo "*Waktu server" >> /tmp/siapa.txt
cat /tmp/siapa.txt
