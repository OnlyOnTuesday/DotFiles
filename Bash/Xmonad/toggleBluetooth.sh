#!/bin/bash

#toggle bluetooth on/off

#this script is intended to run without any user interaction, but this is
#normally prevented because the tool hciconfig requires root/sudo privileges.
#to circumvent this, permission must be given to the owner/user of the script
#to use hciconfig without providing a password. This has been done by adding the
#following line to the sudoers file:
#<username> ALL=(ALL) NOPASSWD: /bin/hciconfig


bluetooth=`hciconfig | grep DOWN`
bluetooth2=`hciconfig | grep UP`

if [ "$bluetooth" ]; then
    #turn on
    #rfkill prevents bluetooth from turning on after power suspension, etc
    rfkill unblock bluetooth
    sudo hciconfig hci0 up
elif [ "$bluetooth2" ]; then
    #turn off
    sudo hciconfig hci0 down
    rfkill block bluetooth    
fi

