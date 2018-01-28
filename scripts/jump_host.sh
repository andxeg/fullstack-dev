#!/bin/bash

BACK_1='192.168.1.64'
BACK_2='192.168.1.107'
JUMP_HOST='95.163.251.121'

if ps -p $SSH_AGENT_PID > /dev/null
then
	echo "ssh-agent is already running"
	ssh-add ./my_winterschools
else
	echo "start ssh-agent"
	eval `ssh-agent`
	ssh-add ./my_winterschools
fi

# ssh -N -f -A -i my_winterschools -L 127.0.0.1:9999:192.168.1.64:80 -L 127.0.0.1:9998:192.168.1.107:80 student6@95.163.251.121

# for connection to backends
# ssh -N -f -A -i my_winterschools -L 127.0.0.1:9999:$BACK_1:80 -L 127.0.0.1:9998:$BACK_2:80 student6@$JUMP_HOST

# for example with flask
# ssh -N -f -A -i my_winterschools -L 127.0.0.1:9999:192.168.1.64:8080 student6@95.163.251.121

ssh -A -i my_winterschools student6@95.163.251.121





