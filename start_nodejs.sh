#!/bin/bash
#
# run netcat listening on 1234 to simulate a TCP/IP based server
# exec nc -l 1234 &>/dev/null &
#
#
echo "Sleepy..."
sleep 5
#
echo "Starting Node"
cd /home/vcap/app/node
node server.js
