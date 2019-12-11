#!/bin/bash -x
echo "Welcome Gambler Game"

BET=1
STAKE=100

winloss=$((RANDOM%2))

case $winloss in

	1)
		echo "win";;
	0)
		echo "loss";;
esac
