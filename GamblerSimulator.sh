#!/bin/bash -x
echo "Welcome Gambler Game"

BET=1
STAKE=100
WIN=1
LOSS=0

cash=0
totalDay=20
day=0

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

		$WIN)
			cash=$(($cash+1));;
		$LOSS)
			cash=$(($cash-1));;
		esac
	done

	winLossDiff=$(($cash-$STAKE))
	totalAmt["Day_$day"]=$winLossDiff
done
}

function getDailyAmt(){

	for ((i=1;i<=20;i++))
	do
		echo "Day_$i ${totalAmt[Day_$i]}"
	done
}

function getLuckyUnLuckyDay(){

	totalAmt[Day_0]=0
	for ((i=1;i<=20;i++))
	do

		k=$(( $i - 1 ))
		totalAmt[Day_$i]=$(( ${totalAmt[Day_$i]} + ${totalAmt[Day_$k]} ))
		echo "Day$i ${totalAmt[Day_$i]}"
	done | sort -k2 -nr | awk 'NR==20{print "UnLucky " $0}AND NR==1{print "Lucky " $0}'
}

function playNxtMnthOrNot()
{
	if (( $1 <= 0 ))
	then
		main
	fi
}

function main()
{
gamblingForDay
getDailyAmt
totalAmt=$( printf "%d\n" ${totalAmt[@]} | awk '{sum+=$0}END{print sum}' )
playNxtMnthOrNot $totalAmt
getLuckyUnLuckyDay
}

main
