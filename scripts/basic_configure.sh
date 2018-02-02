#!/bin/bash
USER='student6'
CURRENT_DIR="$(pwd)"

PROJECT_DIR="/home/student6/fullstack-dev"

# centos update
sudo yum -y update

# selinux disable
KEY='SELINUX'
VAL='disabled'
FILE='/etc/selinux/config'

sed -i "s/^\($KEY\s*=\s*\).*\$/\1$VAL/" $FILE
sudo setenforce 0


# install basic packages
sudo yum install -y mc vim git wget
echo "alias mc='. /usr/libexec/mc/mc-wrapper.sh'" >> /home/$USER/.bashrc


# install epel repo with a lot of extra packages
sudo yum install -y epel-release


# instead build-essential
sudo yum groupinstall -y 'Development Tools'
sudo yum install -y python-devel mysql-devel


# install other packages
sudo yum install -y python-pip
sudo pip install --upgrade pip
sudo pip install virtualenv


# go to project directory and configure environment
sudo rm -rf $PROJECT_DIR
sudo mkdir $PROJECT_DIR
sudo chown -R $USER:$USER $PROJECT_DIR
chmod -R 744 $PROJECT_DIR
cd $PROJECT_DIR
virtualenv venv
source ./venv/bin/activate

# see task_1.txt
pip install Flask
pip install uwsgi
# see also emperor mode of uwsgi
# link -> https://gist.github.com/bluekvirus/62691d0bed98f45fe153a600e127e37b
pip install flask-mysqldb


# go to project directory and download git-repository with scripts and source code
cd $PROJECT_DIR
git clone https://github.com/andxeg/fullstack-dev-server.git server
git clone https://github.com/andxeg/fullstack-dev-client.git client

echo -e '[user]\n\temail = atom1543@yandex.ru' > /home/$USER/.gitconfig
echo -e '\tname = Andrew Chupakhin' >> /home/$USER/.gitconfig
echo -e '[alias]\n\t hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph' >> /home/$USER/.gitconfig


# return to directory from script was launched
cd $CURRENT_DIR 
