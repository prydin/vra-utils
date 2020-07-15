#!/bin/bash
USER=$1
PASS=$2
apt update
echo "$USER:$PASS" | /usr/sbin/chpasswd
echo "$USER:$PASS" | /usr/sbin/chpasswd
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
service ssh reload
