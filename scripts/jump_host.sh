#!/bin/bash

if ps -p $SSH_AGENT_PID > /dev/null
then
	echo "ssh-agent is already running"
	ssh-add ./my_winterschools
else
	echo "start ssh-agent"
	eval `ssh-agent`
	ssh-add ./my_winterschools
fi

# ssh -N -f -A -i my_winterschools -L 127.0.0.1:9999:192.168.1.108:80 -L 127.0.0.1:9998:192.168.1.142:80 student6@95.163.251.121
ssh -A -i my_winterschools student6@95.163.251.121


