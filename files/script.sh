#!/bin/bash

logfile=`tail -n +$2 $1`

echo "IP addesses with the number of  request:"
echo "$logfile" | cut -d ' ' -f 1 | sort | uniq -c | sort -nr | head -n 10

echo "Addresses with the number of  request:"
echo "$logfile" | awk '{print $7}' | sort | uniq -c | sort -nr | head -n 10

echo "Errors since the last launch:"
echo "$logfile" | awk '{print $9}' | sort | grep -P '^4|^5' | uniq 

echo "List all codes:"
echo "$logfile" | awk '{print $9}' | sort | grep -P '[0-9]' | uniq -c


last_run=$(tail -n 1 $1 | awk '{print $4}')
echo ${last_run:1} > /var/tmp/last_run