#!/bin/sh
#get the screen brightness, displays it in text graphic format

#There's no good formula that I can think of right now to do this neatly,
#so we're just going to determine the brightness values manually and write
#them in like that.  bleh.

#this file ranges from 0 to 416, with slightly inconsistent value changes.
brightness=`cat /sys/class/backlight/intel_backlight/brightness`

case $brightness in
    0)   graph="[----------]" ;;
    5)   graph="[+---------]" ;;
    51)  graph="[++--------]" ;;
    96)  graph="[+++-------]" ;;
    142) graph="[++++------]" ;;
    187) graph="[+++++-----]" ;;
    234) graph="[++++++----]" ;;
    278) graph="[+++++++---]" ;;
    325) graph="[++++++++--]" ;;
    370) graph="[+++++++++-]" ;;
    416) graph="[++++++++++]" ;;
    *)   graph="[----!!----]" ;;
esac

echo $graph

exit 0
