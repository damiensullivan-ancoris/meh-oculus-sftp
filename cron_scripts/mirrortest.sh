#!/bin/bash

USER=oculusagentro
PASSWD=$(gcloud secrets versions access latest --secret="oculusagent-ftps-password")

# MEH Sftp Server Host.
FTPSHOST=192.168.18.23

#MEH Sftp Server Source Folder. 
SOURCEDIR=Temp/djstest

#GCP GCS Bucket. 
DESTDIR=/home/oculusagent/meh-ftps-sync/meh-oculus-datadumps/djstest

lftp -u "$USER","$PASSWD" ftp://$FTPSHOST:21 <<EOF
set xfer:clobber on
cd $SOURCEDIR
pwd
ls
lcd $DESTDIR
lpwd
!dir 
EOF

# lftp -u "$USER","$PASSWD" ftp://$FTPSHOST:21 <<EOF
# set xfer:clobber on
# cd $SOURCEDIR
# ls
# lcd $DESTDIR 
# mget *.* 
# lpwd
# bye
# EOF