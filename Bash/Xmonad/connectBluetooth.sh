#!/bin/bash

#connect to bluetooth device without too much/any user input

coproc bluetoothctl
echo -e 'paired-devices\nexit' >&${COPROC[1]}
output=$(cat <&${COPROC[0]})
#my understanding of the regex below is that it searches
#for color codes, deletes them, and then searches for
#carriage returns and replaces them with new lines
#https://www.linuxquestions.org/questions/programming-9/control-bluetoothctl-with-scripting-4175615328/
echo $output | sed 's/\x1B\[[0-9;]*[JKmsu]//g; s/\r/\n/g' | grep 'Boltune'

