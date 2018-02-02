#!/bin/bash

VALID_HASH="c070b754ce2de9f714ab4db4736c7e05"

wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
HASH="$(md5sum mysql57-community-release-el7-11.noarch.rpm)"
set -- $HASH

if [ "$1" == "$VALID_HASH" ]
then
    echo "md5sum is valid"
else
    echo "md5sum is not valid"
    exit
fi

sudo rpm -ivh mysql57-community-release-el7-11.noarch.rpm
rm mysql57-community-release-el7-11.noarch.rpm

sudo yum -y update
sudo yum install -y mysql-server

sudo systemctl start mysqld
sudo systemctl enable mysqld

# configuring MySQL
# sudo grep 'temporary password' /var/log/mysqld.log
# sudo mysql_secure_installation
# change password then press enter to all questions

# for remote access
# add to /etc/my.cnf -> bind-address = 192.168.1.64
# open port -> sudo /sbin/iptables -A INPUT -i eth0 -p tcp --destination-port 3306 -j ACCEPT
# sudo iptables-save
# sudo iptables -L
# sudo netstat -lpn | less
