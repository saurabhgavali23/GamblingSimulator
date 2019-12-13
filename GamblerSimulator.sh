#!/bin/bash -x
echo "Welcome Gambler Game"

BET=1
STAKE=100
WIN=1
LOSS=0
TOTAL_DAY=20

cash=0
day=0

lowLimit=$(($STAKE - (50*$STAKE) / 100 ))
highLimit=$(($STAKE + (50*$STAKE) / 100 ))

declare -A totalAmt

function gamblingForDay(){

	for (( day=1;day<=$TOTAL_DAY;day++ ))
	do

		cash=$STAKE
		while (( $cash > $lowLimit && $cash < $highLimit ))
		do

			winLoss=$((RANDOM%2))
			case $winLoss in

			$WIN)
				cash=$(($cash+$BET));;

			$LOSS)
				cash=$(($cash-$BET));;

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

	for ((i=1;i<=20;i++))
	do

		val=$(( $i + 1 ))
		if (( val <= 20 ))
		then
			totalAmt[Day_$i]=$(( ${totalAmt[Day_$i]} + ${totalAmt[Day_$val]} ))
		fi
		echo "Day$i ${totalAmt[Day_$i]}"

	done | sort -k2 -nr | awk 'NR==20{print "UnLucky " $0}AND NR==1{print "Lucky " $0}'
}

function playNxtMnthOrNot(){

	if (( $1 <= 0 ))
	then
		main
	fi
}

function main(){

	gamblingForDay
	getDailyAmt
	totalAmt=$( printf "%d\n" ${totalAmt[@]} | awk '{sum+=$0}END{print sum}' )
	playNxtMnthOrNot $totalAmt
	getLuckyUnLuckyDay
}

main
