wget https://raw.githubusercontent.com/sairman/ssh/master/installerwebmin.sh
curl https://raw.githubusercontent.com/sairman/ssh/master/installerovpn.sh > openvpn.sh
wget https://raw.githubusercontent.com/sairman/ssh/master/installerwebserver.sh
chmod +x installerwebmin.sh
sh installerwebmin.sh
chmod +x openvpn.sh
./openvpn.sh
chmod +x installerwebserver.sh
sh installerwebserver.sh
