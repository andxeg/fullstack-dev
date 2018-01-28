#!/bin/bash
USER='student6'
CURRENT_DIR="$(pwd)"

# centos update
sudo yum -y update

# install basic packages
sudo yum install -y mc vim git
echo "alias mc='. /usr/libexec/mc/mc-wrapper.sh'" >> /home/$USER/.bashrc

# install epel repo with a lot of extra packages
sudo yum install -y epel-release

# instead build-essential
sudo yum groupinstall -y 'Development Tools'
sudo yum install -y python-devel


# install other packages
sudo yum install -y python-pip
sudo pip install --upgrade pip
sudo pip install virtualenv
virtualenv env
cd ./env
. ./bin/activate
pip install Flask
pip install uwsgi



# download git-repository with scripts and source code
cd /home/$USER
git clone https://github.com/andxeg/fullstack-dev.git

echo -e '[user]\n\temail = atom1543@yandex.ru' > /home/$USER/.gitconfig
echo -e '\tname = Andrew Chupakhin' >> /home/$USER/.gitconfig
echo -e '[alias]\n\t hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph' >> /home/$USER/.gitconfig


# return to directory from script was launched
cd $CURRENT_DIR 
