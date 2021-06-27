# PiholeUpdateScript v0.1
A simple bash script to force an update directly from pihole's official site without the need of editing paths everytime (When you dont store your Webdata in the /var/www/html)


# The directory where your Webdata should be stored
webroot="/webroot/pi"

# The default directory, where pihole installs the webpage by default (dont change this!)
defaultWebroot="/var/www/html"

# Set a reboot flag after installation options: true | false default: true
reboot=true
