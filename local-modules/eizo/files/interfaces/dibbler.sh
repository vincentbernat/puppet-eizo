#!/bin/sh

{
case "$1" in
    delete)
        ip -6 addr delete dev $IFACE scope global
        ;;
    add|update)
        ip -6 addr add ${PREFIX1}1/128 dev $IFACE scope global
        ;;
esac
} | logger --priority user.notice --tag dibbler 2>&1 | logger --priority user.error --tag dibbler
