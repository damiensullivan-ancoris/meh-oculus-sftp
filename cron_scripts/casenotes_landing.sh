#!/bin/bash

USER=oculusagentro
PASSWD=$(gcloud secrets versions access latest --secret="oculusagent-ftps-password")

# MEH Sftp Server Host.
FTPSHOST=192.168.18.23

#MEH Sftp Server Source Folder. 
SOURCEDIR=CaseNotes/Landing

#GCP GCS Bucket. 
DESTDIR=/home/oculusagent/meh-ftps-sync/meh-oculus-datadumps/CaseNotes/Landing

lftp -u "$USER","$PASSWD" ftp://$FTPSHOST:21 <<EOF
set xfer:clobber on
mirror -r -I z.txt $SOURCEDIR $DESTDIR
bye
EOF




