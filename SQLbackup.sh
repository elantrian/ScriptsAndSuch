#!/bin/bash
# A backup script (SQL)
# first install automysqlbackup!

curtime=`date`

# Backup SQL using automysqlbackup
cd /var/lib/automysqlbackup
automysqlbackup
git add .
git commit -m "Auto Tar Valon SQL Backup @ $curtime"
git pull
git push -u origin master

cd ~

#Notes:
#- To restore SQL database from backup:
#gunzip < /var/lib/automysqlbackup/weekly/my_wiki/my_wiki_week.18.2016-05-07_15h32m.sql.gz|my
#sql -uUSER -pPASSWORD my_wiki
