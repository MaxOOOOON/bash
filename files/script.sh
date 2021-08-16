#!/bin/bash
logfile=$1

echo "IP addesses with the number of  request:"
cat $logfile | cut -d ' ' -f 1 | sort | uniq -c | sort -nr | head -n 10

echo "Addresses with the number of  request:"
cat $logfile | awk '{print $7}' | sort | uniq -c | sort -nr | head -n 10

echo "Errors since the last launch:"
cat $logfile | awk '{print $9}' | sort | grep -P '^4|^5' | uniq 

echo "List all codes:"
cat $logfile | awk '{print $9}' | sort | grep -P '[0-9]' | uniq -c