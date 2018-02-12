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

# add MySQL instances configuration
cat ../config/my.cnf | sudo tee --append /etc/my.cnf > /dev/null

sudo systemctl start mysqld@instance01
sudo systemctl enable mysqld@instance01

sudo systemctl start mysqld@instance02
sudo systemctl enable mysqld@instance02


#------------------------------------------------------------------------------

# make two instances of MySQL on one server
# see link -> https://dev.mysql.com/doc/refman/5.7/en/using-systemd.html

# configuring MySQL
# sudo grep 'temporary password' /var/log/mysqld.log
# sudo mysql_secure_installation
# change password then press enter to all questions

# configuring MySQL instances
# Set new password for root.
# https://dev.mysql.com/doc/refman/5.7/en/default-privileges.html
# mysql -u root -S /var/lib/mysql-instance01/mysql.sock -P 3307 -p
# mysql -u root -S /var/lib/mysql-instance02/mysql.sock -P 3308 -p

# for remote access add 
# /etc/my.cnf -> bind-address = 192.168.1.64
# open port -> sudo /sbin/iptables -A INPUT -i eth0 -p tcp --destination-port 3306 -j ACCEPT
# sudo iptables-save
# sudo iptables -L
# sudo netstat -lpn | less
# mysql client remote access see in scripts/jump_host.sh

# create user for each instance of MySQL
# https://linode.com/docs/databases/mysql/how-to-install-mysql-on-centos-7/
# create example DB
# https://www.digitalocean.com/community/tutorials/a-basic-mysql-tutorial


# mysql -u root -S /var/lib/mysql-instance02/mysql.sock -P 3308 -p$(sudo grep 'temporary password' /var/log/mysqld-instance02.log  | cut -d':' -f4 | cut -d' ' -f2)

# EXAMPLE MYSQL FROM BASH SCRIPT
#!/bin/bash

# PORT=$1
# DB_NAME=$2
# PASSWORD='P@ssw0rd'
# TABLE_NAME='potluck'

# mysql -u user -h 127.0.0.1 -P $PORT -p$PASSWORD $DB_NAME<<EOFMYSQL
# select * from $TABLE_NAME;
# EOFMYSQL







