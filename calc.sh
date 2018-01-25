#!/bin/bash

server="10.143.119.27"
user=yanivbl
port=10000

calc=$1


if [[ $2 -lt 32 ]];then
	size_bits=$2
	size=`echo "2^$size_bits" | bc`
else
	size=$2
fi
shift 2

if [[ calc -gt 1 ]]; then
	##remote_size=$((size/calc))
	remote_size=$size
	calc_cmd=" --calc $calc "
else
	remote_size=$size
	calc_cmd=""
fi


echo "Running remote with size $remote_size"
rm_cmd="/yanivbl/perftest/ib_send_bw -p $port --report_gbits -s $remote_size > /dev/null 2> /dev/null"
echo "$rm_cmd"
ssh root@$server "$rm_cmd" &
sleep 3
echo "Running Local with size $size"
l_cmd="./ib_send_bw $server -p $port --report_gbits -s $size $calc_cmd 2> /dev/null"
echo "$l_cmd"
eval $l_cmd
