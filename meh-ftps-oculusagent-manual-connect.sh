#!/bin/bash

PASSWD=$(gcloud secrets versions access latest --secret="oculusagent-ftps-password")
lftp ftp://oculusagent:$PASSWD@192.168.18.23
