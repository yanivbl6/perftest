#!/bin/bash


chunk=$1

if [[ -z $chunk ]]; then
	chunk=1024
fi
echo chunk= $chunk

sizes=(7 8 9 10 11 12 13 14 15 16 17 18 19 20)
vecs=(1 2 4 8 16)


echo "Removing old folder..."
rm -rf /tmp/calc/
mkdir -p /tmp/calc/
wait

for v in "${vecs[@]}"; do


	tar=/tmp/calc/vec$v
	mkdir $tar

	for s in "${sizes[@]}"; do
		size=`echo "2^$s" | bc`
		rcv_size=$((size/v))
		echo "Running size $size with $v vectors"
		./calc.sh $v $rcv_size $chunk > $tar/out_$size.tmp 2> /dev/null
		cat $tar/out_$size.tmp | grep -A 1 "#byte" > $tar/out_$size.log
		wait
		rm $tar/out_$size.tmp
	done
done

python plot.py
python relative_plot.py
