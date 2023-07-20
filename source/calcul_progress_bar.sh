#!/bin/bash

script_name="../extra/nvidia-cuda.sh"
bar_line=$(wc -l $script_name | cut -d " " -f 1)
bar_line_calc=$(echo "100/$bar_line" | bc -l)
count=0
cat_script=$(cat ../extra/nvidia-cuda.sh)
progress=0
progress_max=$(echo "$bar_line*$bar_line_calc" | bc -l)

while read line ; do
    echo "$line"
    progress=$(echo "$progress+$bar_line_calc" | bc -l)
    count=$((count+1))
done < $script_name

if [[ $count == $bar_line ]] ; then
    echo "FINI $count"
    echo "progress $progress"
    echo "progress_max $progress_max"
fi

if [[ $progress == $progress_max ]] ; then
    echo "GAGNE"
else
    echo "PERDU"
fi

