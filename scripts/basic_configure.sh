#!/bin/bash
USER='student6'
CURRENT_DIR="$(pwd)"
PROJECT_DIR="/home/student6/fullstack-dev"


# centos update
echo '[INFO] Centos Update'
sudo yum -y update


# selinux disable
KEY='SELINUX'
VAL='disabled'
FILE='/etc/selinux/config'

echo '[INFO] Disable SELinux'
sudo sed -i "s/^\($KEY\s*=\s*\).*\$/\1$VAL/" $FILE
sudo setenforce 0


# install basic packages
echo '[INFO] Install basic packages'
sudo yum install -y mc vim git wget
echo "alias mc='. /usr/libexec/mc/mc-wrapper.sh'" >> /home/$USER/.bashrc


# install epel repo with a lot of extra packages
echo '[INFO] Epel-release installation'
sudo yum install -y epel-release


# instead build-essential
echo '[INFO] Development Tools installation'
sudo yum groupinstall -y 'Development Tools'
sudo yum install -y python-devel mysql-devel


# install other packages
echo '[INFO] Other packages installation'
sudo yum install -y python-pip
sudo pip install --upgrade pip
sudo pip install virtualenv


# go to project directory and configure environment
echo '[INFO] Environment configuration'
sudo rm -rf $PROJECT_DIR
sudo mkdir $PROJECT_DIR
sudo chown -R $USER:$USER $PROJECT_DIR
chmod -R 744 $PROJECT_DIR
cd $PROJECT_DIR
virtualenv --python=python2.7 venv
source ./venv/bin/activate

# see task_1.txt
echo '[INFO] Python packages installation'
pip install Flask
pip install uwsgi
# see also emperor mode of uwsgi
# link -> https://gist.github.com/bluekvirus/62691d0bed98f45fe153a600e127e37b
pip install flask-mysqldb


# go to project directory and download git-repository with scripts and source code
echo '[INFO] Download remote repositories'
cd $PROJECT_DIR
git clone https://github.com/andxeg/fullstack-dev-server.git server
git clone https://github.com/andxeg/fullstack-dev-client.git client

echo -e '[user]\n\temail = atom1543@yandex.ru' > /home/$USER/.gitconfig
echo -e '\tname = Andrew Chupakhin' >> /home/$USER/.gitconfig
echo -e '[alias]\n\t hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph' >> /home/$USER/.gitconfig


# return to directory from script was launched
cd $CURRENT_DIR 
