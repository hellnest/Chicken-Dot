#!/bin/bash
# D-Bus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
   eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults

exec ck-launch-session dbus-launch subtle
