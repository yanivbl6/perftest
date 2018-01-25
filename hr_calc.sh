#!/bin/bash


start=4096
step=64
end=12888
size=()
for i in $(seq $start $step $end); do sizes+=($i); done
##sizes=( 4096 4352 4608 4864 5120 5376 5632 5888 6144 6400 6656 6912 7168 7424 7680 7936 8192 8448 8704 8960 9216 9472 9728 )

vecs=( 1 8 16 )

echo "Removing old folder..."
rm -rf /tmp/calc/
mkdir -p /tmp/calc/
wait

for v in "${vecs[@]}"; do
	tar=/tmp/calc/vec$v
	mkdir $tar
	echo $tar
	for s in "${sizes[@]}"; do
		if [[ $s -lt 32 ]]; then
			size=`echo "2^$s" | bc`
		else
			size=$s
		fi
		echo "Running size $size with $v vectors"
		./calc.sh $v $s > $tar/out_$size.tmp 2> /dev/null
		cat $tar/out_$size.tmp | grep -A 1 "#byte" > $tar/out_$size.log
		wait
		rm $tar/out_$size.tmp
	done
done

python plot.py
