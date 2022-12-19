#!/bin/bash

public_server_ip="xxxxxx.xxx.xxx" # public IP of server
lowest_port_number_file=/tmp/lowest_port_number


config_client=/tmp/keys
config_server=/tmp/keys_server
config_temp=/tmp/config_tmp

mkdirhier $config_client
mkdirhier $config_server
mkdirhier $config_temp

server_ip=$1 # private IP of server
client_ip=$2 # private IP of client

ls $lowest_port_number_file || echo 5000 > $lowest_port_number_file

server_port=`cat $lowest_port_number_file`

let "server_port=$server_port+1"
echo $server_port > $lowest_port_number_file

keyfile=$config_temp/secret.key

keyfilebn=`basename $keyfile`

openvpn --genkey --secret $keyfile

cat > $config_temp/server.conf   <<HEREDOCUMENT
port $server_port
dev tun
ifconfig $server_ip $client_ip
secret $keyfilebn
keepalive 10 120
comp-lzo
HEREDOCUMENT

cat > $config_temp/client.conf   <<HEREDOCUMENT
remote $public_server_ip
port $server_port
dev tun
ifconfig $client_ip $server_ip
secret $keyfilebn
keepalive 10 120
comp-lzo
HEREDOCUMENT

#rm $config_client/client_config$server_port.zip 
zip -j $config_client/client_config$server_port.zip $keyfile $config_temp/client.conf
#rm $config_server/server_config$server_port.zip
zip -j $config_server/server_config$server_port.zip $keyfile $config_temp/server.conf

rm $keyfile $config_temp/server.conf $config_temp/client.conf
