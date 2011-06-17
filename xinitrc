#!/bin/bash
LAUNCH=ck-launch-session dbus-launch
DEFAULT=startfluxbox

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
   eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults 

case $1 in
  subtle)   exec $START subtle      ;;
*)          exec $START $DEFAULT    ;;
esac
