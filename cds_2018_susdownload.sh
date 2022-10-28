#!/bin/bash

USER=oculusagent
PASSWD=$(gcloud secrets versions access latest --secret="oculusagent-ftps-password")

# MEH Sftp Server Host.
FTPSHOST=192.168.18.23

#MEH Sftp Server Source Folder. 
SOURCEDIR=Temp/djstest

#GCP GCS Bucket. 
DESTDIR=/home/oculusagent/meh-ftps-sync/meh-oculus-datadumps/CDS_2018/Grouper/Output

lftp -c "open ftp://$USER:$PASSWD@$FTPSHOST:21; set xfer:clobber on; cd $SOURCEDIR; ls; lcd $DESTDIR; mget *.*; lpwd; bye"

##