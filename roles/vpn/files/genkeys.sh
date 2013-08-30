#!/bin/sh

cd /etc/openvpn/easy-rsa/2.0/
. /etc/openvpn/easy-rsa/2.0/vars
/etc/openvpn/easy-rsa/2.0/clean-all
# /etc/openvpn/easy-rsa/2.0/build-ca
/etc/openvpn/easy-rsa/2.0/pkitool --initca
# /etc/openvpn/easy-rsa/2.0/build-key-server server
/etc/openvpn/easy-rsa/2.0/pkitool --server
/etc/openvpn/easy-rsa/2.0/build-dh