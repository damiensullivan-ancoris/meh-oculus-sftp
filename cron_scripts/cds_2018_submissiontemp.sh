USER=oculusagentro
PASSWD=$(gcloud secrets versions access latest --secret="oculusagent-ftps-password")

# MEH Sftp Server Host.
FTPSHOST=192.168.18.23

#MEH Sftp Server Source Folder. 
SOURCEDIR=CDS_2018/SubmissionTemp

#GCP GCS Bucket. 
DESTDIR=/home/oculusagent/meh-ftps-sync/meh-oculus-datadumps/CDS_2018/SubmissionTemp

lftp -u "$USER","$PASSWD" ftp://$FTPSHOST:21 <<EOF
set xfer:clobber on
mirror -I CDSEDS63_Freeze_* -I CDSEDS63_Flex_* -I CDSEDS63_SinceFriday_* -I CDSEDS63_FiveWeeks_* $SOURCEDIR $DESTDIR
mirror -I CDSOUT62_Freeze_* -I CDSOUT62_Flex_* -I CDSOUT62_SinceFriday_* -I CDSOUT62_FiveWeeks_* $SOURCEDIR $DESTDIR
mirror -I CDSAPK62_Freeze_* -I CDSAPK62_Flex_* -I CDSAPK62_SinceFriday_* -I CDSAPK62_FiveWeeks_* -I CDSAPK62_HRG_* $SOURCEDIR $DESTDIR
bye
EOF

# ALTERNATE MGET EVERY TIME APPROACH
# lftp -c "open ftp://$USER:$PASSWD@$FTPSHOST:21; set xfer:clobber on; cd $SOURCEDIR; ls; lcd $DESTDIR; mget CDSEDS63_Freeze_* CDSEDS63_Flex_* CDSEDS63_SinceFriday_* CDSEDS63_FiveWeeks_* ; lpwd; bye"
# lftp -c "open ftp://$USER:$PASSWD@$FTPSHOST:21; set xfer:clobber on; cd $SOURCEDIR; ls; lcd $DESTDIR; mget CDSOUT62_Freeze_* CDSOUT62_Flex_* CDSOUT62_SinceFriday_* CDSOUT62_FiveWeeks_*; lpwd; bye"
# lftp -c "open ftp://$USER:$PASSWD@$FTPSHOST:21; set xfer:clobber on; cd $SOURCEDIR; ls; lcd $DESTDIR; mget CDSAPK62_Freeze_* CDSAPK62_Flex_* CDSAPK62_SinceFriday_* CDSAPK62_FiveWeeks_* CDSAPK62_HRG_*; lpwd; bye"

# NOTES:
# mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSEDS63_Freeze_
# mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSEDS63_Flex_
# mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSEDS63_SinceFriday_
# mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSEDS63_FiveWeeks_

# mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSOUT62_Freeze_
# mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSOUT62_Flex_
# mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSOUT62_SinceFriday_
# mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSOUT62_FiveWeeks_

# \mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSAPK62_Freeze_*
# \mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSAPK62_Flex_*
# \mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSAPK62_SinceFriday_*
# \mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSAPK62_FiveWeeks_*
# \mehdwssdt\c$\DataDumps\CDS_2018\SubmissionTemp\CDSAPK62_HRG_*