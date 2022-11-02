USER=oculusagentro
PASSWD=$(gcloud secrets versions access latest --secret="oculusagent-ftps-password")

# MEH Sftp Server Host.
FTPSHOST=192.168.18.23

#MEH Sftp Server Source Folder. 
SOURCEDIR=CDS_2018/SUSdownload

#GCP GCS Bucket. 
DESTDIR=/home/oculusagent/meh-ftps-sync/meh-oculus-datadumps/CDS_2018/SubmissionTemp

lftp -c "open ftp://$USER:$PASSWD@$FTPSHOST:21; set xfer:clobber on; cd $SOURCEDIR; ls; lcd $DESTDIR; mget CDSEDS63_Freeze_* CDSEDS63_Flex_* CDSEDS63_SinceFriday_* ; lpwd; bye"

# NOTES:
# mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSEDS63_Freeze_
# mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSEDS63_Flex_
# mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSEDS63_SinceFriday_