#!/bin/bash

PORT=$1
DB_NAME=$2
PASSWORD=$3
TABLE_NAME='potluck'

mysql -u user -h 127.0.0.1 -P $PORT -p$PASSWORD $DB_NAME<<EOFMYSQL
select * from $TABLE_NAME;
EOFMYSQL

