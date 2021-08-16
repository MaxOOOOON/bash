#!/bin/bash
lastaccess=$(tail -n 1 /vagrant_files/access-4560-644067.log | awk '{print $4}')
#grep -n 'http://www.yahoo.com' file1


/vagrant_files/script.sh /vagrant_files/access-4560-644067.log > /var/tmp/result
sendmail -v vanya.9werty@gmail.com < /var/tmp/result
