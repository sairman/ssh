wget https://raw.githubusercontent.com/sairman/ssh/master/installerwebmin.sh
curl https://raw.githubusercontent.com/sairman/ssh/master/installerovpn.sh > openvpn.sh
wget https://raw.githubusercontent.com/sairman/ssh/master/installerwebserver.sh
chmod +x installerwebmin.sh
sh installerwebmin.sh
chmod +x openvpn.sh
./openvpn.sh
chmod +x installerwebserver.sh
sh installerwebserver.sh
cp /etc/openvpn/clientconfig/client-udp.ovpn /home/vps/public_html
cp /etc/openvpn/clientconfig/client-tcp.ovpn /home/vps/public_html
cd /usr/bin
curl https://raw.githubusercontent.com/sairman/ssh/master/cek-user.sh > cek
chmod +x cek
./cek
