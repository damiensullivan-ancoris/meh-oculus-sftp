#!/bin/bash

USER=oculusagentro
PASSWD=$(gcloud secrets versions access latest --secret="oculusagent-ftps-password")

# MEH Sftp Server Host.
FTPSHOST=192.168.18.23

#MEH Sftp Server Source Folder. 
SOURCEDIR=CDS_2018/Grouper

#GCP GCS Bucket. 
DESTDIR=/home/oculusagent/meh-ftps-sync/meh-oculus-datadumps/CDS_2018/Grouper

lftp -u "$USER","$PASSWD" ftp://$FTPSHOST:21 <<EOF
set xfer:clobber on
mirror --file=$SOURCEDIR/zOUTin.csv --file=$SOURCEDIR/zAPKin.csv $SOURCEDIR $DESTDIR
bye
EOF




