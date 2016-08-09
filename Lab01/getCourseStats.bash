#! /bin/bash
#
#$Author: ee364b06 $
#$Date: 2016-01-20 20:37:16 -0500 (Wed, 20 Jan 2016) $
#$HeadURL: svn+ssh://ece364sv@ecegrid-thin1/home/ecegrid/a/ece364sv/svn/S16/students/ee364b06/Lab01/getCourseStats.bash $
#$Revision: 86416 $
cnt=0
sum=0
max=0
c=0
if (( $# == 1 ))
then
    if [[ $1 == "ece364" ]] || [[ $1 == "ece337" ]] || [[ $1 == "ece468" ]]
    then
        for content1 in $(ls gradebooks/$1*)
        do
            ./getFinalScores.bash $content1
            if (( $? != 0 ))
            then
                echo "Error while running getFinalScores.bash"
                exit 3
            fi
        done
        
        for content2 in $(ls gradebooks/$1*.out)
        do
            while read c
            do 
                let cnt=$cnt+1
                if (( $(echo $c | cut -f 2 -d ',') > max ))
                then
                    max=$(echo $c | cut -f 2 -d ',');
                    maxname=$(echo $c | cut -f 1 -d ',')
                fi
                let sum=$(echo $c | cut -f 2 -d ',')+$sum
            done<$content2
        done 
            let avg=$sum/$cnt
            
            echo "Total students: $cnt"
            echo "Average score: $avg"
            echo "$maxname had the highest score of $max"
         
    else
        echo "Error course $1 is not a valid option."
        exit 5
    fi
else
    echo "Usage: ./getCourseStats.bash <course name>"
    exit 1
fi
exit 0



