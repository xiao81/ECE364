#! /bin/bash
#
#$Author$
#$Date$
#$HeadURL$
#$Revision$

if (( $# != 1 ))
then
    echo 'Usage: scheduler.bash <filename>'
    exit 1
fi

if [[ ! -e $1 || ! -r $1 ]]
then
    echo "Error: $1 is not a readable file"
    exit 2
fi
if [[  -e "schedule.out" ]]
then
    echo "Error: schedule.out already exists"
    exit 3
fi

exec 3<$1
arr=("07:00" "08:00" "09:00" "10:00" "11:00" "12:00" "13:00" "14:00" "15:00" "16:00" "17:00")
echo ${arr[*]} >schedule.out
while read line <&3
do
    name=$(echo $line | cut -f1 -d " ")
    arr1=("-" "-" "-" "-" "-" "-" "-" "-" "-" "-" "-")
    for(i=1; i<12 ;i++)
    do
	item=($(echo $line | cut -f2 -d " " | cut -f $i -d ","))
	if($item==(($i+5)))
    done
done
exit 0


