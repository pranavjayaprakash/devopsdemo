#!/bin/bash
#kitlog='kitchencreate.log'
#inslog='instance.log'
#kitlog=`kitchen create`
id=`kitchen create | grep requested | awk -F "<" '{print $2}' | cut -c 1-19`
#ip=`cat $inslog | grep PublicIpAddress | awk -F ":" '{print $2}' | sed 's/[",]//g'`
ip=`aws ec2 describe-instances --instance-ids $id | grep PublicIpAddress | awk -F ":" '{print $2}' | sed 's/[",]//g'`
echo 'ip is:' $ip
echo 'id is:' $id
echo default[\'ssl_host\'][\'ip\'] = \'$ip\' > ip
#echo `pwd`
sed -i '$d' attributes/default.rb
sed -i '/ssl_key/r ip' attributes/default.rb
