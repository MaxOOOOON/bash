# bash

Отправка происходит через утилиту sendmail
Установка:  
     `sudo apt install ssmtp`

Файл настроек /etc/ssmtp/ssmtp.conf выглядит так:

     UseSTARTTLS=YES
     FromLineOverride=YES
     root=ivanov@gmail.com
     mailhub=smtp.gmail.com:587
     AuthUser=ivanov@gmail.com
     AuthPass=pass

Отправка осуществляется командой:  
     `sendmail ivanov@gmail.com  < file`

Для того чтобы скрипт выполнялся раз в час, необходимо прописать через crontab -e :

     0 */1 * * * /vagrant_files/mail.sh


Защита от мультизапуска реализована через lockfile.

Вывод результата:

     [root@centos8 vagrant_files]# cat /var/tmp/result
     Time range from 14/Aug/2019:04:12:10 to 15/Aug/2019:00:25:46
     IP addesses with the number of  request:
          45 93.158.167.130
          39 109.236.252.130
          37 212.57.117.19
          33 188.43.241.106
          31 87.250.233.68
          24 62.75.198.172
          22 148.251.223.21
          20 185.6.8.9
          17 217.118.66.161
          16 95.165.18.146
     Addresses with the number of  request:
         157 /
         119 /wp-login.php
          57 /xmlrpc.php
          26 /robots.txt
          12 /favicon.ico
          11 400
           9 /wp-includes/js/wp-embed.min.js?ver=5.0.4
           7 /wp-admin/admin-post.php?page=301bulkoptions
           7 /1
           6 /wp-content/uploads/2016/10/robo5.jpg
     Errors since the last launch:
     400
     403
     404
     405
     499
     500
     List all codes:
         498 200
          95 301
           1 304
           7 400
           1 403
          51 404
           1 405
           2 499
           3 500
