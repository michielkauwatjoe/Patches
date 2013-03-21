#!/bin/bash
#--------------------------------------------------
#
# This line should be in crontab:
#
# 00 01 * * * /path/to/script/backup.sh > /dev/null 2>&1
#
# Open it with crontab -e.
#--------------------------------------------------

# Location of the backup logfile. TODO use it.
#logfile="backup.log"
#touch $logfile

# Location to place backups.
backup_dir="backups"
timeslot=`date +%y-%m-%d.%H:%M`
year=`date +%Y`
month=`date +%m`
servername="myserver.com"

# Scan for databases.
databases=`psql -l | sed -n 4,/\eof/p | grep -v rows\) | awk {'print $1'}`

for i in $databases; do
	if [ $i != ":" ] && \
		[ $i != "template0" ] && \
		[ $i != "vipcode" ] && \
		[ $i != "amex" ] && \
		[ $i != "postgres" ] && \
		[ $i != "wolvennest" ] && \
		[ $i != "kanet" ] && \
		 [ $i != "template1" ]; then
		vacuumdb -z $i >/dev/null 2>&1
		pg_dump $i | gzip > "$backup_dir/db-backup-$i-$timeslot-$servername.gz"
		echo "Finished backup for $i database."
	fi

done

#-------------------------------------------------
# Now call Python script that uses boto to copy
# the files to S3.
#-------------------------------------------------

echo `python 2s3.py`


