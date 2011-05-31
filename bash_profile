# Sane locale
export LANG=en_US-UTF8
export LC=$LANG
export LC_COLLATE=C


# Daily Stuff

if [ -n "$DISPLAY" ]; then
	BROWSER=luakit
else
	BROWSER=links
fi

export BROWSER="luakit"
export EDITOR="vim"
export VISUAL="vim"
export TERM="rxvt-256color"
export LANG="en_US.UTF8"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export IRC_CLIENT="irssi"
export PATH="/usr/lib/colorgcc/bin:/usr/bin/core_perl:$HOME/bin:$PATH"
export QT_GRAPHICSSYSTEM=raster

#if interactive source, $HOME/.bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

#Start Login
if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
  exec startx
fi
