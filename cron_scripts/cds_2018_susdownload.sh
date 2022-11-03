#!/bin/bash

USER=oculusagentro
PASSWD=$(gcloud secrets versions access latest --secret="oculusagent-ftps-password")

# MEH Sftp Server Host.
FTPSHOST=192.168.18.23

#MEH Sftp Server Source Folder. 
SOURCEDIR=CDS_2018/SUSdownload

#GCP GCS Bucket. 
DESTDIR=/home/oculusagent/meh-ftps-sync/meh-oculus-datadumps/CDS_2018/SUSdownload

lftp -u "$USER","$PASSWD" ftp://$FTPSHOST:21 <<EOF
set xfer:clobber on
mirror -I APK_SUS_Download.csv -I ECS_SUS_Download.csv -I OUT_SUS_Download.csv $SOURCEDIR $DESTDIR
bye
EOF

# DOWNLOAD Completely every time
#lftp -c "open ftp://$USER:$PASSWD@$FTPSHOST:21; set xfer:clobber on; cd $SOURCEDIR; ls; lcd $DESTDIR; mget *.csv; lpwd; bye"

## NOTES
# File Manifest
# \\mehdwssdt\c$\DataDumps\CDS_2018\SUSdownload\APK_SUS_Download.csv
# \\mehdwssdt\c$\DataDumps\CDS_2018\SUSdownload\ECS_SUS_Download.csv
# \\mehdwssdt\c$\DataDumps\CDS_2018\SUSdownload\OUT_SUS_Download.csv
# Cron Frequency TODO: verify with CM

