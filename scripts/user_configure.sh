#!/bin/bash

USER='student6'
CURRENT_DIR="$(pwd)"

# check for root
USER_ID=$(id -u)

if [ x$USER_ID != x0 ]
then
    # add user to sudo
    echo 'go to root mode'
    # note! exec lauch new process. below code won't be executed
    exec sudo su -c "usermod -a -G wheel $USER"
fi
