#!/bin/sh

xmodmap -e "pointer = 1 0 3" &
xrdb -merge $HOME/.Xdefaults &
xset r rate 220 45 &
setxkbmap -option terminate:ctrl_alt_bksp &
xsetroot -d :0 -cursor_name left_ptr &
urxvtd -q -o -f &
autocutsel -s PRIMARY &                     
unclutter -idle 1 &
~/bin/rwpaper &

exec ck-launch-session subtle
