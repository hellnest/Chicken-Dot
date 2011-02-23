#!/bin/zsh

eval `dbus-launch --sh-syntax --exit-with-session`
eval "$(gpg-agent --daemon --log-file /home/lee/gpglog)"
xmodmap -e "pointer = 1 0 3"
xset +dpms
xrdb -merge $HOME/.Xdefaults &
xset r rate 220 45
setxkbmap -option terminate:ctrl_alt_bksp
xsetroot -d :0 -cursor_name left_ptr

## Daemon Array
#urxvtd -q -o -f
#autocutsel -s PRIMARY &
mpd &
#bitlbee &
unclutter -idle 1 &
#(sleep 1 && ck-launch-session nm-applet) &
~/bin/rwpaper &
#(sleep 2 && ~/bin/dcomp.sh) &
#~/bin/hd &
#(sleep 5 && conky -c ~/conky/ctime) &
#(sleep 5 && dropboxd) &

## i Hate Java ##
wmname LG3D

#wm_bin="$1"
#exec ${wm_bin}
#exec ck-launch-session awesome
#exec ck-launch-session awesome >~/.xsession-errors 2>&1
exec ck-launch-session xmonad >~/.xmonad-session 2>&1
