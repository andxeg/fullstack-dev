#!/bin/bash

NGINX_REPO_PATH='/etc/yum.repos.d/nginx.repo'

echo 'nginx configure'
echo 'creating file nginx.repo'
sudo sh -c "touch $NGINX_REPO_PATH"
sudo sh -c "echo -e '[nginx]\nname=nginx repo\nbaseurl=http://nginx.org/packages/centos/7/x86_64/\ngpgcheck=0\nenabled=1\n' >> $NGINX_REPO_PATH"

echo 'install nginx'
sudo yum install -y nginx

echo 'start nginx'
sudo systemctl start nginx
sudo systemctl enable nginx
