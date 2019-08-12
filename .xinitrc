
#import style and behaviour settings
#load polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# load style stuff to make my env look nice (and maybe some behaviour stuff)

xrdb -merge $HOME/.Xresources

# start system stuff that's useful in grahical environments

#systemctl --user start xinputConf.service
#these are also stored in a bash script/system service for when loading directly
#into a graphical session
xinput set-prop 12 289 1
xinput set-prop 12 297 1

#systemctl --user start xscreensaver.service
#this is also stored in a bash script/system service for when loading directly
#into a graphical session
#I don't know if this will work before xmonad is exec'd
$HOME/Bash/xmonadInit/locker.sh 

#systemctl --user start xss-lock.service
#this is also stored in a bash script/system service for when loading directly
#into a graphical session
#I don't know if this will work before xmonad is exec'd
$HOME/Bash/xmonadInit/xss.sh

exec xmonad
#exec startxfce4
