#!/bin/sh

## router IP address
router_ip_address=192.168.1.1

## black-listed domains
blacklist=~/blocked-domains
## the blacklist is a list of domains to block, one per line

## under normal circumstances  ##
## do not edit below this line ##

## adblock-wrt54g
## (c) atom@smasher.org, 5 Sep 2006, 1 Mar 2008
## PGP = 762A 3B98 A3C3 96C9 C6B7  582A B88D 52E4 D9F5 7808
## distributed under GPL - http://www.gnu.org/copyleft/gpl.html

## make a backup copy of the original dnsmasq.conf, if a backup doesn't exist
## append the formatted black list to dnsmasq.conf
## kill and restart dnsmasq

awk '{print "address=/"$1"/127.0.0.1"}' < ${blacklist} | 		\
    ssh root@${router_ip_address} '[ -f /tmp/dnsmasq.conf.orig ] &&	\
    cp /tmp/dnsmasq.conf.orig /tmp/dnsmasq.conf ||			\
    cp /tmp/dnsmasq.conf /tmp/dnsmasq.conf.orig
    cat - >> /tmp/dnsmasq.conf &&					\
    kill -9 $(cat /var/run/dnsmasq.pid) &&				\
    /usr/sbin/dnsmasq --conf-file /tmp/dnsmasq.conf'

