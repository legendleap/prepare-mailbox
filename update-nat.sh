#!/bin/bash

# run this script as a cron job and pass the floating IP as argument
# this is to make sure this rule will override other rules
# so that outgoing connections will use the floating IP.

# delete existing rules, make sure there is no duplicate rule
for i in 1 2; do
	iptables -t nat -D POSTROUTING -o eth0 -p tcp --dport 25 -j SNAT --to-source $1
done

# insert it back at the top of the chain
iptables -t nat -I POSTROUTING -o eth0 -p tcp --dport 25 -j SNAT --to-source $1
