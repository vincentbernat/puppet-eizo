#! /bin/sh
IPTABLES=/sbin/iptables

$IPTABLES -t nat -F MINIUPNPD
$IPTABLES -t nat -F MINIUPNPD-PCP-PEER
$IPTABLES -t filter -F MINIUPNPD
$IPTABLES -t mangle -F MINIUPNPD

IP6TABLES=/sbin/ip6tables

$IP6TABLES -t filter -F MINIUPNPD
$IP6TABLES -t mangle -F MINIUPNPD

:
