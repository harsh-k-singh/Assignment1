#!/bin/bash

while IFS="," read -r col1 col2 col3
do
    if [ "$col1" = "time" ]; then
        continue
    fi

    send_hour=$(echo "$col1" | cut -d ":" -f1)
    send_min=$(echo "$col1" | cut -d ":" -f2 )
    t1=$(($send_hour * 3600))
    t2=$(($send_min * 60))
    time=$(($t1 + $t2))
    time=$(($time - 1800 ))

    echo "$time,$col2,$col3" >> new_file.csv
done < tasks.properties

(sort -t, -k1,1 new_file.csv ) >sorted.csv

while IFS="," read -r col1 col2 col3
do
    cur_hr=$(date +%H | sed 's/^0*//')
    cur_min=$(date +%M | sed 's/^0*//')
    t11=$(($cur_hr * 3600))
    t22=$(($cur_min * 60))
    curr_time=$(($t11 + $t22))
    diff_in_time=$(($col1 - $curr_time))

    if [ $diff_in_time -gt 0 ]; then
        sleep $diff_in_time
    fi

    f=answer1
    mkdir -p $f/$col2
    noti_count=$(find $f/$col2/ -name notification*.txt  | wc -l )
    noti_count=$((noti_count + 1))
    echo "$col3" >> answer1/$col2/Notification$noti_count.txt
    echo "Notification sent to : $col2 "


done < sorted.csv

rm new_file.csv
rm sorted.csv

