#!/bin/bash

# Defining some colors
NORMAL='\033[0;37m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[0;31m'


# The directory where your Webservers pihole should be stored
webroot="/webroot/pi"

# The default directory, where pihole installs the webpage by default
defaultWebroot="/var/www/html"

# Set a reboot flag after installation options: true | false default: true
reboot=true

############################################################################
############################################################################
############################################################################
############################################################################

if ! [ $(id -u) = 0 ]; then
   echo -e "$RED The script need to be run as root." >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

# Gaining space to show the settings |||| instead of the for loop we can just clear the screen..
clear
echo -e "$NORMAL PiHole update script written by$GREEN Timo Baginski\n\n"

#for i in {1..50}
#do
#       echo -e " \n"
#done

echo -e "$NORMAL Choosen settings: \n"
echo -e "$NORMAL \t Your webroot: \t\t\t" $BLUE $webroot $NORMAL
echo -e "$NORMAL \t Default root: \t\t\t" $BLUE $defaultWebroot $NORMAL
echo -e "$NORMAL \t Reboot after installation: \t" $GREEN $reboot $NORMAL
echo -e "$NORMAL \n Sleeping for 3 seconds to check the settings\n Press Ctrl + C to abbort.." $NORMAL

#instead of the for loop we can just add \n
#for i in {1..15}
#do
#       echo -e " \n"
#done
echo -e "\n\n"

sleep 3

# Downloading the latest pihole version
echo "$GREEN Trying to download the latest version of PiHole.."

wget -O basic-install.sh https://install.pi-hole.net

sed -i 's|webroot="/var/www/html"|webroot="/webroot/pi"|g' /tmp/basic-install.sh
sleep 3
# Installing Pihole
bash /tmp/basic-install.sh &
BACK_PID=$!
#TIMEOUT=0
#TIMEOUT_MAX=32
while ps -p $BACK_PID > /dev/null; do sleep 1;done
#       $TIMEOUT +=1
#       if ($TIMEOUT -eq $TIMEOUT_MAX) ; THEN
#       echo "$REDA timeout occoured. Maybe Pi-Hole is not available or your internet connection got lost."$NORMAL
#       fi

#Cleaning up
echo -e "$NORMAL Cleaning up.."
rm /tmp/basic-install.sh

# Force Reboot after installation
if [ $reboot = "true" ]; then
        echo -e "$GREEN Pihole successfully updated. Restarting in 3 seconds.$NORMAL"
        sleep 3
        reboot
elif [ $reboot = "false" ]; then
        echo -e "$GREEN Pihole successfully updated. No restart was forced.$NORMAL"
        sleep 3
fi
exit 1
