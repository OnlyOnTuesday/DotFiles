#!/bin/bash

#check the status of bluetooth and display a character as a result

bluetooth=`hciconfig | grep DOWN`
bluetooth2=`hciconfig | grep UP`

if [ "$bluetooth" ]; then
    #off
    echo [/]
elif [ "$bluetooth2" ]; then
    #on
    echo [B]
fi

