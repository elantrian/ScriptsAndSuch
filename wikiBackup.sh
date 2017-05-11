#!/bin/bash
# A backup script (wiki)

curtime=`date`
now=$(date +"%m_%d_%Y")
cd /var/www/html/halcyon/w

# Backup wiki file system
echo Zipping file system
echo ...might take a while...
_file=wikiFS_$now.tgz
tar --exclude-vcs --exclude='./dumps' --exclude='*wikiFS*' --exclude='$_file' -zchf  $_file ./
echo $PWD
echo File system zipped into $_file

# Dump XML files
_file2=wikiXML_$now.xml.gz
php ./maintenance/dumpBackup.php --full --output=gzip:./dumps/$_file2
echo $PWD
echo XML dumped into $_file2


# Dump uploads
_file3=wikiFiles_$now.tar
php ./maintenance/dumpUploads.php php | xargs tar cf ./dumps/$_file3
echo $PWD
echo Images dumped into $_file3


git add .
git commit -m "Auto Elantris Backup @ $curtime"
git push origin master

cd ~
echo Back in $PWD
echo Done!
