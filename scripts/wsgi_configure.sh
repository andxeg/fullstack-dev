#!/bin/bash

USER='student6'
WSGI_SERVER_NAME='uwsgi'
PROJECT_DIR="/home/student6/fullstack-dev"

echo 'add '$WSGI_SERVER_NAME' as a service'
sudo cp ../config/uwsgi /etc/init.d/
sudo chmod 755 /etc/init.d/uwsgi

cp  ../config/app_uwsgi.ini $PROJECT_DIR

sudo systemctl daemon-reload
sudo systemctl restart uwsgi
