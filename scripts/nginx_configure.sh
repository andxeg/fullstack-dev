#!/bin/bash

NGINX_REPO_PATH='/etc/yum.repos.d/nginx.repo'
NGINX_CONFIG_PATH='/etc/nginx/conf.d/*.conf'

echo 'nginx configure'
echo 'creating file nginx.repo'
sudo sh -c "touch $NGINX_REPO_PATH"
sudo sh -c "echo -e '[nginx]\nname=nginx repo\nbaseurl=http://nginx.org/packages/centos/7/x86_64/\ngpgcheck=0\nenabled=1\n' >> $NGINX_REPO_PATH"

echo 'install nginx'
sudo yum install -y nginx

echo 'backup previous nginx config files'
for i in $(sudo ls $NGINX_CONFIG_PATH)
do
	sudo mv $i $i'.backup'
done

echo 'add new config to /etc/nginx/conf.d/'
sudo cp ../config/app_nginx.conf /etc/nginx/conf.d

echo 'start nginx'
sudo systemctl start nginx
sudo systemctl enable nginx
