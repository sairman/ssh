apt-get install -y openvpn
cp -a /usr/share/doc/openvpn/examples/easy-rsa /etc/openvpn/
cd /etc/openvpn/easy-rsa/2.0
source ./vars
./clean-all
./build-ca
