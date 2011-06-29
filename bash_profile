# Sane locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.utf8


# Daily Stuff

if [ -n "$DISPLAY" ]; then
	BROWSER="firefox"
else
	BROWSER="links"
fi

export BROWSER="firefox"
export EDITOR="vim"
export VISUAL="vim"
export TERM="rxvt-256color"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export PATH="/usr/lib/colorgcc/bin:/usr/bin/core_perl:$HOME/bin:$PATH"
export QT_GRAPHICSSYSTEM="raster"
export DIFFPROG="meld"
export SCREEN_CONF_DIR="$HOME/.screen/configs"
export SCREEN_CONF="main"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# need to solve vim issue when using root
export XAUTHORITY="$HOME/.Xauthority"

#if interactive source, $HOME/.bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

#Start Login
#if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
#  exec xinit
#fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
