#!/usr/bin/env bash 

#Получение необходимого диапазона лога
logfile=`tail -n +$2 $1`

#X IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта;
echo "IP addesses with the number of  request:"
echo "$logfile" | cut -d ' ' -f 1 | sort | uniq -c | sort -nr | head -n 10

#Y запрашиваемых адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта;
echo "Addresses with the number of  request:"
echo "$logfile" | awk '{print $7}' | sort | uniq -c | sort -nr | head -n 10

# все ошибки c момента последнего запуска;
echo "Errors since the last launch:"
echo "$logfile" | awk '{print $9}' | sort | grep -P '^4|^5' | uniq 

#список всех кодов возврата с указанием их кол-ва с момента последнего запуска.
echo "List all codes:"
echo "$logfile" | awk '{print $9}' | sort | grep -P '[0-9]' | uniq -c

#Запись времени последней записи лога
last_run=$(tail -n 1 $1 | awk '{print $4}')
echo ${last_run:1} > /var/tmp/last_run