#!/bin/sh
INET_IFACE="ppp0"

LAN_IFACE="wlan0"

LO_IFACE="lo"

LO_IP="127.0.0.1"

IPTABLES="/usr/sbin/iptables"

echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all
echo 1 > /proc/sys/net/ipv4/ip_dynaddr
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
echo 1 > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses
echo 1 > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses
echo 1 > /proc/sys/net/ipv4/conf/all/rp_filter
echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route
echo 0 > /proc/sys/net/ipv4/conf/all/accept_redirects
echo 0 > /proc/sys/net/ipv4/conf/all/secure_redirects
echo 1 > /proc/sys/net/ipv4/conf/all/proxy_arp
echo 1 > /proc/sys/net/ipv4/ip_forward
for f in /proc/sys/net/ipv4/conf/*/rp_filter ; do echo 1 > $f ; done

$IPTABLES -F
$IPTABLES -t nat -F

$IPTABLES -P INPUT DROP
$IPTABLES -P OUTPUT DROP
$IPTABLES -P FORWARD DROP

$IPTABLES -N bad_tcp
$IPTABLES -N allowed
$IPTABLES -N tcp_pkg


$IPTABLES -A bad_tcp -p tcp --tcp-flags SYN,ACK SYN,ACK -m state --state NEW -j DROP
$IPTABLES -A bad_tcp -p tcp ! --syn -m state --state NEW -j LOG --log-prefix "New not syn:"
$IPTABLES -A bad_tcp -p tcp ! --syn -m state --state NEW -j DROP

$IPTABLES -A allowed -p TCP --syn -j ACCEPT
$IPTABLES -A allowed -p TCP -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPTABLES -A allowed -p TCP -j DROP

$IPTABLES -A tcp_pkg -p TCP -s 0/0 --dport 443  -j allowed
$IPTABLES -A tcp_pkg -p TCP -s 0/0 --dport 6881 -j allowed
$IPTABLES -A tcp_pkg -p TCP -s 0/0 --dport 8000 -j allowed

$IPTABLES -A INPUT -p ALL -m  state --state INVALID -j DROP
$IPTABLES -A INPUT -p ALL -i  $LO_IFACE  -j ACCEPT
$IPTABLES -A INPUT -p ALL -i  $LAN_IFACE  -j ACCEPT
$IPTABLES -A INPUT -p TCP -j  bad_tcp
$IPTABLES -A INPUT -p ALL -i  $INET_IFACE -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPTABLES -A INPUT -p TCP -i  $INET_IFACE -j tcp_pkg

$IPTABLES -A OUTPUT -p ALL -s $LO_IP      -j ACCEPT
$IPTABLES -A OUTPUT -p ALL -o $INET_IFACE -j ACCEPT
$IPTABLES -A OUTPUT -p ALL -o $LAN_IFACE -j ACCEPT

$IPTABLES  -I FORWARD -i $LAN_IFACE  -d 192.168.11.1/255.255.0.0 -j DROP
$IPTABLES  -A FORWARD -i $LAN_IFACE  -s 192.168.11.1/255.255.0.0 -j ACCEPT
$IPTABLES  -A FORWARD -i $INET_IFACE -d 192.168.11.1/255.255.0.0 -j ACCEPT
$IPTABLES  -t nat -A POSTROUTING -o $INET_IFACE -j MASQUERADE
