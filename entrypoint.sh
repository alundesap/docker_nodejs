#!/bin/bash
#
export CHISEL_USERNAME=$(echo $VCAP_SERVICES | jq -r '."user-provided"[0].credentials.chisel_username')
export CHISEL_PASSWORD=$(echo $VCAP_SERVICES | jq -r '."user-provided"[0].credentials.chisel_password')
export CHISEL_SERVER=$(echo $VCAP_SERVICES | jq -r '."user-provided"[0].credentials.chisel_server_url')
# 3306 is the default port for MySQL
#export CHISEL_TUNNEL_PORT=3306
export CHISEL_TUNNEL_PORT=$(echo $VCAP_SERVICES | jq -r '."user-provided"[0].credentials.chisel_tunnel_port')

# run netcat listening on 1234 to simulate a TCP/IP based server
# exec nc -l 1234 &>/dev/null &
#
# Start the NodeJS Server
#
#exec /usr/local/bin/start_nodejs.sh &>/dev/null &
su -p -c /usr/local/bin/start_nodejs.sh vcap &>/dev/null &
#
#
# Start the Chisel Tunnel Client
#
#exec chisel client --keepalive 1m --auth eclipse:Initial1 https://docker-mysqls.cfapps.us10.hana.ondemand.com 3306
exec chisel client --keepalive 1m --auth $CHISEL_USERNAME:$CHISEL_PASSWORD $CHISEL_SERVER $CHISEL_TUNNEL_PORT
