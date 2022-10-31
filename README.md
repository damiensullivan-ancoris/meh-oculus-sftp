# meh-oculus-sftp

Author: Damien Sullivan
Date: 19/10/2022 

Overview: Moorfields Eye Hospital (MEH) Oculus project (Ancoris Data Team) have a requirement to ingest file based data sources from MEH to GCP GCS.  

Solution: 
1) Repurpose existing GCP Oculus Project Compute VM. VM Name = ft   
https://console.cloud.google.com/compute/instancesDetail/zones/europe-west2-c/instances/ft?project=meh-oculus&pageState=(%22duration%22:(%22groupValue%22:%22PT1H%22,%22customValue%22:null))
    
2) Patch to latest OS 
DONE - VERSION="22.04.1 LTS (Jammy Jellyfish)"

3) Install GCSFUSEs
DONE install notes for linux --> https://github.com/GoogleCloudPlatform/gcsfuse/blob/master/docs/installing.md

4) Install lftp 
DONE - apt install lftp 

5) Add new user oculusagent
DONE - 	$ sudo useradd -m oculusagent
$ sudo passwd oculusagent (password in GCP Oculus project Secret Manager : oculusagent-bash-password) 

6) Create /home/oculusagent/.lftprc 
	   
```   
set ftps:initial-prot ""
set ftp:ssl-force true
set ftp:ssl-protect-list true
set ftp:ssl-protect-data true
set ssl:verify-certificate no
#open ftp://192.168.18.23:21
#user oculusagent
```

7) Create GCS Bucket (no public access - Europe-west2 London)
DONE - 	meh-oculus-datadumps
https://console.cloud.google.com/storage/browser/meh-oculus-datadumps;tab=objects?forceOnBucketsSortingFiltering=false&project=meh-oculus&prefix=&forceOnObjectsSortingFiltering=false 

8) Create GCSFUSE Drive Mapping on VM ft
DONE - /home/oculusagent/meh-ftp-sync/meh-oculus-datadumps
lftp ftp://oculusagent:$PASSWD@192.168.18.23:21/CDS_2018/Grouper/Output/

9) Create GCP Secret Manager keys. 
DONE - 
$ gcloud secrets versions access latest --secret="oculusagent-ftps-password"
$ gcloud secrets list
NAME                       CREATED              REPLICATION_POLICY  LOCATIONS
oculusagent-bash-password  2022-10-19T10:02:49  automatic           -
oculusagent-ftps-password  2022-10-19T10:04:44  automatic           -
	
10) Create ftps synch file for CDS_2018/Grouper/Output

$ mkdir -p /home/oculusagent/meh-ftps-sync/meh-oculus-datadumps/CDS_2018/Grouper/Output
```	
#!/bin/bash
USER=oculusagent
PASSWD=$(gcloud secrets versions access latest --secret="oculusagent-ftps-password")
FTPSHOST=192.168.18.23
#SOURCEDIR=CDS_2018/Grouper/Output
SOURCEDIR=Temp/djstest
DESTDIR=/home/oculusagent/meh-ftps-sync/meh-oculus-datadumps/CDS_2018/Grouper/Output

lftp -c "open ftp://$USER:$PASSWD@$FTPSHOST:21; set xfer:clobber on; cd $SOURCEDIR; ls; lcd $DESTDIR; mget *.*; lpwd; bye"
```

11) Create cron to sync at specific time or frequency
```
$ sudo apt install cron 
$ crontab -e
```	

## Access oculusagent shell account

SSH into ft server via GCP Console Link. 

https://ssh.cloud.google.com/v2/ssh/projects/meh-oculus/zones/europe-west2-c/instances/ft?authuser=0&hl=en_GB&projectNumber=366334205566&useAdminProxy=true&troubleshoot4005Enabled=true&troubleshoot255Enabled=true&sshTroubleshootingToolEnabled=true&regional=true
```
$ su - oculusagent
Password: enter password 

Either GCP Secret Manager or gcloud can be used to obtain password. 

$ gcloud secrets versions access latest --secret="oculusagent-ftps-password"
```

## MANUALLY CONNECT TO MEH ftps Server

If you would like to manually connect to ftps within the MEH environment, run the following
```
PASSWD=$(gcloud secrets versions access latest --secret="oculusagent-ftps-password")
lftp ftp://oculusagent:$PASSWD@192.168.18.23
```

## TODO
>> TODO: GCSFUSE Mapping on host server reboot