#!/bin/bash

USER=oculusagentro
PASSWD=$(gcloud secrets versions access latest --secret="oculusagent-ftps-password")

# MEH Sftp Server Host.
FTPSHOST=192.168.18.23

#MEH Sftp Server Source Folder. 
SOURCEDIR=Temp/djstest
#SOURCEDIR=CDS_2018/SubmissionTemp

#GCP GCS Bucket. 
DESTDIR=/home/oculusagent/meh-ftps-sync/meh-oculus-datadumps/djstest


#-I CDSEDS63_Freeze_* -I CDSEDS63_Flex_* -I CDSEDS63_SinceFriday_* -I CDSEDS63_FiveWeeks_*

lftp -u "$USER","$PASSWD" ftp://$FTPSHOST:21 <<EOF
set xfer:clobber on
mirror -I *.log -I *.txt $SOURCEDIR $DESTDIR
mirror -I *.dog -I *.dxt $SOURCEDIR $DESTDIR
mirror -I *.bog -I *.ext $SOURCEDIR $DESTDIR
bye
EOF

# lftp -u "$USER","$PASSWD" ftp://$FTPSHOST:21 <<EOF
# set xfer:clobber on
# mirror -I CDSEDS63_Freeze_* -I CDSEDS63_Flex_* -I CDSEDS63_SinceFriday_* -I CDSEDS63_FiveWeeks_* $SOURCEDIR $DESTDIR
# bye
# EOF

# lftp -u "$USER","$PASSWD" ftp://$FTPSHOST:21 <<EOF
# set xfer:clobber on
# cd $SOURCEDIR
# pwd
# ls
# lcd $DESTDIR
# lpwd
# !dir 
# bye
# EOF

# lftp -u "$USER","$PASSWD" ftp://$FTPSHOST:21 <<EOF
# set xfer:clobber on
# cd $SOURCEDIR
# ls
# lcd $DESTDIR 
# mget *.* 
# lpwd
# bye
# EOF