#!/usr/bin/env bash 

LOCKFILE=/tmp/lock.txt
if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
    echo "already running"
    exit
fi


trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
echo $$ > ${LOCKFILE}

#Подавление вывода команд
exec &> /dev/null

last_run=`cat /var/tmp/last_run`
logfile=/vagrant_files/access-4560-644067.log

#Проверка на предыдущий запуск и есть ли последняя запись, с предыдущего запуска, в логе
#Если скрипт уже выполнялся, то получаем первую строку для обработки и время первой строки лога  
#Иначе лог читается с первой строки 

if ls /var/tmp/last_run  && grep -n $last_run $logfile; then 
first_line=$(grep -n $last_run $logfile | head -n 1 | cut -d: -f -1)
from_time=$last_run   
else 
first_line=0
from_time=$(cut -f 4 -d ' ' $logfile | head -n 1)
from_time=${from_time:1}
fi


#Время последней строки лога
to_time=$(cut -f 4 -d ' ' $logfile | tail -n 1)



#Запись временного диапазона
echo "Time range from $from_time to ${to_time:1}" > /var/tmp/result
echo "----------------------------------------------" >> /var/tmp/result
#Выполнение скрипта с передачей параметров лог файла и первой строки дял чтения
/vagrant_files/script.sh $logfile $first_line >> /var/tmp/result
#Отправляем данные из файла на почту
sendmail -v ivanov@gmail.com < /var/tmp/result

rm -f ${LOCKFILE}

#useful commands
#  grep -n "182.254.243.249" /vagrant_files/access-4560-644067.log | grep -E '15/Aug/2019:00:24:38'\
#  awk '/yahoo/{y=1;next}y' data.txt
#  echo ${v%:*} # убрать всё после последнего двоеточия
#  echo ${v#*:} # убрать всё до первого двоеточия
#exec 3>myfile
#echo "and this should be stored in the file" >&3