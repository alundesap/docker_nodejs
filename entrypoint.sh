#!/bin/bash
#
# run netcat listening on 1234 to simulate a TCP/IP based server
# exec nc -l 1234 &>/dev/null &
#
# Start the NodeJS Server
#
#exec /usr/local/bin/start_nodejs.sh &>/dev/null &
#
#
# Start the Chisel Tunnel Client
#
exec chisel client --keepalive 1m --auth eclipse:Initial1 https://mysqls.cfapps.us10.hana.ondemand.com 3306
