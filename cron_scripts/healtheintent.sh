#!/bin/bash

USER=oculusagentro
PASSWD=$(gcloud secrets versions access latest --secret="oculusagent-ftps-password")

# MEH Sftp Server Host.
FTPSHOST=192.168.18.23

#MEH Sftp Server Source Folder. 
SOURCEDIR=HealthEintent

#GCP GCS Bucket. 
DESTDIR=/home/oculusagent/meh-ftps-sync/meh-oculus-datadumps/HealthEintent

LOGFILE=$DESTDIR/ftps_log/HealthEintent.log

lftp -u "$USER","$PASSWD" ftp://$FTPSHOST:21 <<EOF
set xfer:clobber on
mirror -r -I HCCG_UK_MOOR_COVID_INPATIENT* -I AdmCare_v1o6* -I NCLMDS_BatchSend.bat $SOURCEDIR $DESTDIR --log=
bye
EOF




