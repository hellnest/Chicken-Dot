##################################################
##Dynamic Window Manager <MOD> - Chicken Project##
##		xinitrc resources		##
##################################################


##########################
##	X-Tweak		##
##########################
xmodmap -e "pointer = 1 0 3"
xset +dpms +fp /usr/share/fonts/local,/usr/share/fonts/artwiz-fonts
[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults
xscreensaver -no-splash &
#xcompmgr -n -c -C -t-5 -l-5 -r4.2 -o.55 -f 2>/dev/null &
xset r rate 220 45
setxkbmap -option terminate:ctrl_alt_bksp
xsetroot -cursor_name left_ptr

##########################
##	Autostart	##
##########################
urxvtd -q -o -f
mpd &
#conky | while read -r; do xsetroot -name "$REPLY"; done &
~/bin/randomwp &
~/bin/dcomp.sh &
#~/bin/dwm-stat &
#dropboxd &

## i Hate Java ##
#wmname LG3D

#exec ck-launch-session dbus-launch dwm
exec ck-launch-session dbus-launch xmonad
