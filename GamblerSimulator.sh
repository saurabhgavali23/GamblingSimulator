#!/bin/bash -x
echo "Welcome Gambler Game"

BET=1
STAKE=100

cash=0

lowLimit=$(($STAKE/2))
highLimit=$(($STAKE + $lowLimit))

function gamblingForDay()
{
	cash=$STAKE
while (( $cash > $lowLimit && $cash < $highLimit ))
do

	winloss=$((RANDOM%2))

		case $winloss in

		1)
			cash=$(($cash+1));;
		0)
			cash=$(($cash-1));;
		esac
done

echo $cash
}

gamblingForDay
