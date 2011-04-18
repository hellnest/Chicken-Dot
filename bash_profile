# Sane locale
export LC_COLLATE=C


# Daily Stuff

if [ -n "$DISPLAY" ]; then
	BROWSER=firefox
else
	BROWSER=links
fi

export EDITOR="/usr/bin/vim"
export VISUAL="/usr/bin/sublime-text"
export TERM="rxvt-256color"
export LANG="en_US.UTF8"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# QT & KDE Path
export PATH="/usr/lib/colorgcc/bin:/usr/bin/core_perl:/home/lee/bin:$PATH"
export QT_PLUGIN_PATH="$HOME/.kde4/lib/kde4/plugins/:/usr/lib/kde4/plugins/"

# if interactive source, $HOME/.bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
  exec startx
fi
