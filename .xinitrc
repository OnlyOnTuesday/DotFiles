#tap-to-click and proper scrolling
xinput set-prop 12 289 1
xinput set-prop 12 297 1

#colors and what not
xrdb -merge ~/.Xdefaults

#automatically detect external memory attatchments
udiskie &

#set the wallpaper.  run the feh command externally to change wallpaper
~/.fehbg &

#start xscreensaver and auto-lock 
xscreensaver -no-splash &
xss-lock -- /usr/bin/xscreensaver-command -lock &

exec $HOME/.cabal/bin/xmonad
#exec startxfce4
