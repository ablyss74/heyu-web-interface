#!/usr/bin/env bash
set -f

# Author: 	Kris Beazley
# Copyright     2014 
# Online: 	http://heyu.epluribusunix.net/
# Online email: http://heyu.epluribusunix.net/?contactus
# Licensed under the Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0

# Redirect Stderr to stdout. Thanks to Brandt for this snippet. 
debug() { exec 2>&1 ; }

# Check if heyu is owned by us
[[ -e $LOCKDIR/LCK..$TTY && ! -O $LOCKDIR/LCK..$TTY ]] && echo "<h1>Alert!</h1><hr> <form method=post>This script requires ownership of heyu.<br>Please stop any current heyu processes \"heyu stop\" in terminal and <input type=submit value=Refresh name=Refresh> this page.</form>" && exit

# Check if tty port is readable by us
[[ -e /dev/$TTY && ! -r /dev/$TTY ]] && echo "<h1>Alert!</h1><hr> <form method=post>This script requires read/write access to /dev/$TTY.<br>Please stop any current heyu processes \"heyu stop\" in terminal and chmod o+rw /dev/$TTY and then <input type=submit value=Refresh name=Refresh> this page.</form>" && exit

# Check if tty port is writable by us
[[ -e /dev/$TTY && ! -w /dev/$TTY ]] && echo "<h1>Alert!</h1><hr> <form method=post>This script requires read/write access to /dev/$TTY.<br>Please stop any current heyu processes \"heyu stop\" in terminal and chmod o+rw /dev/$TTY and then <input type=submit value=Refresh name=Refresh> this page.</form>" && exit


# Aux inputs
# Check if heyu aux is owned by us
[[ -e $LOCKDIR/LCK..$TTY_AUX  && ! -O $LOCKDIR/LCK..$TTY_AUX ]] && echo "<h1>Alert!</h1><hr> <form method=post>This script requires ownership of heyu.<br>Please stop any current heyu processes \"heyu stop\" in terminal and <input type=submit value=Refresh name=Refresh> this page.</form>" && exit

# Check if tty aux port is readable by us
[[ -e /dev/$TTY_AUX && ! -r /dev/$TTY_AUX ]] && echo "<h1>Alert!</h1><hr> <form method=post>This script requires read/write access to /dev/$TTY_AUX.<br>Please stop any current heyu processes \"heyu stop\" in terminal and chmod o+rw /dev/$TTY_AUX and then <input type=submit value=Refresh name=Refresh> this page.</form>" && exit

# Check if tty aux port is writable by us
[[ -e /dev/$TTY_AUX && ! -w /dev/$TTY_AUX ]] && echo "<h1>Alert!</h1><hr> <form method=post>This script requires read/write access to /dev/$TTY_AUX.<br>Please stop any current heyu processes \"heyu stop\" in terminal and chmod o+rw /dev/$TTY_AUX and then <input type=submit value=Refresh name=Refresh> this page.</form>" && exit

# Alert user to restart 
[[  $QUERY_STRING == *Reset_Cookies* ]] && echo "<h1>Alert!</h1><hr> Cookies are cleared for $SERVER_NAME. <br> Please restart your web browser.
<br><br><i>For smart phones like Android you will need to select \"Force Stop\" in the running applications menu to properly restart the web browser.
<br><br> For some web browsers cookies have to be cleared manually through the web browsers builtin cookie manager.</i>" && exit

[[ $HTTP_COOKIE == *sub3cookie* ]] && [[ $Heyu_web_interface_version != $Interface_version ]]	&& alert_user=true

# Alert user to delete old cookies
[[ -n $alert_user ]] && echo "<h1>Alert!</h1><hr> This version [ $Heyu_web_interface_version ] may not be compatible with your version [ $Interface_version ] of Heyu Web Interface.
<br> Please reset cookies for domain: <a href=#>$SERVER_NAME</a> to avoid any potential conflicts. <form method=post><input type=submit value='Reset Cookies' name=Reset_Cookies=True><br><br><i>
Tip 1:</i> For some web browsers cookies have to be cleared manually through the web browsers builtin cookie manager.
<br><i>Tip 2:</i> If you think you are viewing this page in error you can try <form method=post><input type=submit value='refreshing'> the page." && unset alert_user && exit

### We rely on the heyu engine daemon and therefore must start it automatically even if is not done so in the x10config
[[ $("$heyu" -c "${x10config}" enginestate) != 1 ]] && "$heyu" -c "${x10config}" engine

# Debug script
[[ ${Debug_SCRIPT^^} == TRUE ]] && debug


