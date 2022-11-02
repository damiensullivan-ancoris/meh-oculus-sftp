#!/bin/bash
USERNAME=oculusagentro
PASSWD=$(gcloud secrets versions access latest --secret="oculusagent-ftps-password")

lftp ftp://$USERNAME:$PASSWD@192.168.18.23
