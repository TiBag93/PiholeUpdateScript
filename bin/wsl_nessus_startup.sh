#!/bin/bash

# Defining some colors
NORMAL='\033[0;37m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[0;31m'

#Gaining space for the Output;
clear

echo -e "$NORMAL Nessus Startup Script for WSL Maschines written by$GREEN TiBag93\n\n"

#check permissions
if ! [ $(id -u) = 0 ]; then
   echo -e "$RED The script need to be run as root.\n\n$NORMAL Permission Checker: $RED FAILED $NORMAL" >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi
echo -e "$NORMAL Permission Checker:$GREEN PASSED $NORMAL\n"
# if user has enough permissions:
#check if another instance is running
process_id=$(pidof nessus-service)

if [[ $process_id ]]; then
    echo -e "$RED Process 'nessus-service' is already running\n\n\nAbborting..\n\n" >&2
    exit 1
fi

echo -e "$BLUE Starting Nessus Service..$NORMAL"
echo -e "$NORMAL Waiting for the process to start..\n"
sudo /opt/nessus/sbin/nessus-service &

sleep 8
#BACK_PID=$!
#while ps -p $BACK_PID > /dev/null; do sleep 1;done

echo -e "\n\n\n"

journalctl -u nessus.service

echo -e "\n\n\n"
echo -e "$GREEN Nessus was successfully started.\n\n$NORMAL Navigate to:\n\n$BLUE https://$HOSTNAME:8834/\n$NORMAL\n"

exit 1
