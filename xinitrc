##################################################
##		 Chicken Project		##
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
mpdscriblle &
unclutter -idle 1 &
~/bin/rwpaper &
~/bin/dcomp.sh &
~/bin/hd &
dropboxd &

## i Hate Java ##
#wmname LG3D

exec ck-launch-session xmonad
