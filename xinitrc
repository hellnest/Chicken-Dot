#!/bin/bash
LAUNCH=dbus-launch
DEFAULT=awesome

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
   eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

[[ -f ~/.Xresources ]] && xrdb -all ~/.Xresources 

#--[ This is essential ]--
urxvtd -q -o -f  # Run Rxvt Daemon 
xset r rate 220 45 # Make you Type faster 
xsetroot -cursor_name left_ptr # Set rodent themes :)
xset s off -dmps # Turn off DMPS :) 

case $1 in
  fb)       exec $LAuNCH startfluxbox   ;;
  subtle)   exec $LAUNCH subtle         ;;
  pekwm)    exec $LAUNCH pekwm          ;;
*)          exec $LAUNCH $DEFAULT       ;;
esac
