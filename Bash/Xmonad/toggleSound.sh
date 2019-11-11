#!/bin/bash
#A script to correctly toggle the muted state of Master and Speaker using alsamixer

#The calls to each case statement are associated with a button press within the rc file
#(AwesomeWM).  When I wrote the toggle command for a muted state directly in the file
#it did not work as expected, so I decided to group everything under one file

function toggleMute () {
    #check Master
    #save output to variable
    amixer cget numid=14 | grep -q off
    masterState=$?

    #check Speaker
    #save output to variable
    amixer cget numid=4 | grep -q off
    speakerState=$?

    #if off, turn on and vice versa
    if [[ $masterState -eq 0 || $speakerState -eq 0 ]]
    then
	amixer cset numid=4 on && amixer cset numid=14 on
    else
	amixer cset numid=4 off && amixer cset numid=14 off
    fi
}

function raiseVolume () {
    amixer -q -D pulse sset Master 5%+
}

function lowerVolume () {
    amixer -q -D pulse sset Master 5%-
}

#determine which function to call
case $@ in
    '--toggle') toggleMute;;
    '--raise' ) raiseVolume;;
    '--lower' ) lowerVolume;;
esac


