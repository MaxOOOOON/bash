#!/bin/bash
last_run=`cat /var/tmp/last_run`

if ls /var/tmp/last_run 1> /dev/null && grep -n $last_run /vagrant_files/access-4560-644067.log 1> /dev/null; then 
first_line=$(grep -n $last_run /vagrant_files/access-4560-644067.log | head -n 1 | cut -d: -f -1)
from_time=$last_run   
else 
first_line=0
from_time=$(cut -f 4 -d ' ' /vagrant_files/access-4560-644067.log | head -n 1)
from_time=${from_time:1}
fi


#time range
to_time=$(cut -f 4 -d ' ' /vagrant_files/access-4560-644067.log | tail -n 1)




echo "Time range from $from_time to ${to_time:1}" > /var/tmp/result
echo "----------------------------------------------" >> /var/tmp/result
/vagrant_files/script.sh /vagrant_files/access-4560-644067.log $first_line >> /var/tmp/result
#sendmail -v vanya.9werty@gmail.com < /var/tmp/result



#useful commands
#  grep -n "182.254.243.249" /vagrant_files/access-4560-644067.log | grep -E '15/Aug/2019:00:24:38'\
#  echo ${v%:*} # убрать всё после последнего двоеточия
#  echo ${v#*:} # убрать всё до первого двоеточия