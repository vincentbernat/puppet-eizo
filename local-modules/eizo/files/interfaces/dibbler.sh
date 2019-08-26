#!/bin/sh

set -x

case "$1" in
    delete)
        ip -6 addr delete dev $IFNAME scope global
        ;;
    add|update)
        ip -6 addr add ${PREFIX1%/*}1/128 dev $IFNAME scope global
        ;;
esac
