#!/bin/bash
# Script to deploy nginx config files from local repo to server
ssh shayla -t 'rm -rf /tmp/nginx && mkdir /tmp/nginx'
scp -r /home/restlessmodem/Development/nginx/* shayla:/tmp/nginx
ssh shayla -t 'sudo cp -r /tmp/nginx/* /etc/nginx/ && sudo systemctl restart nginx-modified'
