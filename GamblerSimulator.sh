#!/bin/bash -x
echo "Welcome Gambler Game"

BET=1
STAKE=100

cash=0
totalDay=20
day=0
win=0
loss=0

lowLimit=$(($STAKE/2))
highLimit=$(($STAKE + $lowLimit))

declare -A totalAmt

function gamblingForDay(){

for (( day=1;day<=20;day++ ))
do

		cash=$STAKE
	while (( $cash > $lowLimit && $cash < $highLimit ))
	do

		winloss=$((RANDOM%2))
		case $winloss in

		1)
			cash=$(($cash+1))
			win=$(($win+1));;
		0)
			cash=$(($cash-1))
			loss=$(($loss+1));;
		esac
	done

	totalAmt["Day_$day"]=$win" "$loss
done
}

gamblingForDay

for result in ${!totalAmt[@]}
do
	echo $result "${totalAmt[$result]}"
done | sort -k2 -n
