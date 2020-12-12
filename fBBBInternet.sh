#!/bin/sh
ifconfig enx8030dc87a30c 192.168.7.1
iptables --table nat --append POSTROUTING --out-interface wlp2s0 -j MASQUERADE
iptables --append FORWARD --in-interface enx8030dc87a30c -j ACCEPT
echo 1 > /proc/sys/net/ipv4/ip_forward

