#!/bin/bash

file="booking.csv"

while IFS=" " read -r cl1 cl2 cl3 cl4 cl5 cl6 cl7 cl8 cl9 cl10
do	
	if [ "$cl4" == "booked" ];then
		echo "$cl3,$cl8,$cl10,booked" >> $file

	elif [ "$cl4" == "cancelled" ];then
		awk 
done < log.txt

