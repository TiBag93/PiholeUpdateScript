# PiholeUpdateScript by TiBag93
    LAST UPDATE: May 2023 (untested, since I do not use PiHole anymore)
A simple bash script to force an update directly from pihole's official site without the need of editing paths everytime (When you dont store your Webdata in the /var/www/html)
I've only tested this script on my Ubuntu on a Raspberry Pi 4 4GB

#### The directory where your Webdata should be stored
> webroot="/webroot/pi"

#### The default directory, where pihole installs the webpage by default (dont change this!)
> defaultWebroot="/var/www/html"

#### Set a reboot flag after installation options: true | false default: true
> reboot=true

This script needs root-permissions to work properly. It will ask you for your sudo-password.

#### Installation

1. Download or copy it into your '/bin'-Folder and name it "piholeUpdateScript.sh"
2. Setup your webroot: 
  > sudo nano /bin/piholeUpdateScript.sh
3. Grant privileges 
  > sudo chmod +x piholeUpdateScript.sh
4. Run it whenever you like to update your Pihole.
