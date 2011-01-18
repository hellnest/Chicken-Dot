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
#xscreensaver -no-splash &
xset r rate 220 45
setxkbmap -option terminate:ctrl_alt_bksp
xsetroot -cursor_name left_ptr

##########################
##	Autostart	##
##########################
urxvtd -q -o -f
mpd &
unclutter -idle 1 &
#conky | while read -r; do xsetroot -name "$REPLY"; done &
~/bin/rwpaper &
~/bin/dcomp.sh &
~/bin/hd &
#dropboxd &

## i Hate Java ##
#wmname LG3D

#exec ck-launch-session dbus-launch dwm
exec ck-launch-session xmonad
