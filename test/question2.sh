#!/bin/bash

echo "            RAM Usage  "
echo " "
free -h | awk '/^Mem:/ {print "Free RAM:", $4}'
free -h | awk '/^Mem:/ {print "Used RAM:", $3}'
echo ""
echo""

echo "            Disk Usage "
echo " "
df -h | awk '/dev/ {print "Total Disk Space:", $2}'
df -h | awk '/dev/ {print "Total Disk Used:", $3}'
total=$(df -h --output=size | awk 'NR>1 {sum += $2} END {print sum}')
used=$(df -h --output=size | awk 'NR>1 {sum += $3} END {print sum}')

mkdir -p alerts

if [ $used -gt $(( $total / 2 )) ];
then
	echo "Disk Usage Greater than 50%" >> alerts/Notification.txt
fi

echo " " 
echo " " 
echo "                 Top 10 files in the Files System "
echo " " 
find ~ -type f -exec du -h {} + | sort -rh | head -n 10

