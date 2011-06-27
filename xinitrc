#!/bin/bash
# xinitrc configuration
# Martin Lee (c) 2011
#{{{ Env And Variable
LOG="$HOME/.Xlog"
LAUNCH=dbus-launch
DEFAULT=awesome
#}}}

#{{{ Clean Log File
if (cp /dev/null "${log}"); then
  chmod 600 "${log}"
  exec >"${log}" 2>&1
  break
fi
#}}}

#{{{ Dbus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
   eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi
#}}}

#{{{ Merge .Xresources
[[ -f ~/.Xresources ]] && xrdb -all ~/.Xresources 
#}}}

#{{{ Essential for me
urxvtd -q -o -f & # Run Rxvt Daemon 
xset r rate 220 45 & # Make you Type faster 
xsetroot -cursor_name left_ptr & # Set rodent themes :)
xset s off -dpms & 
xset fp+ /usr/share/fonts/local
#}}}

#{{{ Window Manager
case "$1" in
  failsafe|twm) exec twm
    ;;
  fb)           exec $LAuNCH startfluxbox   
    ;;
  debug)        exec valgrind -v "$1"
    ;;
  *)            exec $LAUNCH $DEFAULT 2> $LOG       
    ;;
esac
#}}}
