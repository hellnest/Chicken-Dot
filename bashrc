cowsay -f daemon $(fortune)

##########################################
##	Chicken Project - Martin Lee	##
##					##
##		Bash.RC			##
##########################################
##########################################
##################################
##	External Config		##
##################################
export PATH="/usr/lib/colorgcc/bin:$PATH"
export EDITOR="vim"
complete -cf sudo
complete -cf man

[[ -z $BASH_COMPLETION && -r /etc/bash_completion ]] && . /etc/bash_completion
[[ -r ~/.dircolors && -x /bin/dircolors ]] && eval $(dircolors -b ~/.dircolors)


# Check for an interactive session
[ -z "$PS1" ] && return

###########
# HISTORY #
###########
HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*"
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL="ignoreboth:erasedups"

##########
##COLORS##
##########
TXTBLK='\[\e[0;30m\]' # Black - Regular
TXTRED='\[\e[0;31m\]' # Red
TXTGRN='\[\e[0;32m\]' # Green
TXTYLW='\[\e[0;33m\]' # Yellow
TXTBLU='\[\e[0;34m\]' # Blue
TXTPUR='\[\e[0;35m\]' # Purple
TXTCYN='\[\e[0;36m\]' # Cyan
TXTWHT='\[\e[0;37m\]' # White
BLDBLK='\[\e[1;30m\]' # Black - Bold
BLDRED='\[\e[1;31m\]' # Red
BLDGRN='\[\e[1;32m\]' # Green
BLDYLW='\[\e[1;33m\]' # Yellow
BLDBLU='\[\e[1;34m\]' # Blue
BLDPUR='\[\e[1;35m\]' # Purple
BLDCYN='\[\e[1;36m\]' # Cyan
BLDWHT='\[\e[1;37m\]' # White
UNDBLK='\[\e[4;30m\]' # Black - Underline
UNDRED='\[\e[4;31m\]' # Red
UNDGRN='\[\e[4;32m\]' # Green
UNDYLW='\[\e[4;33m\]' # Yellow
UNDBLU='\[\e[4;34m\]' # Blue
UNDPUR='\[\e[4;35m\]' # Purple
UNDCYN='\[\e[4;36m\]' # Cyan
UNDWHT='\[\e[4;37m\]' # White
BAKBLK='\[\e[40m\]'   # Black - Background
BAKRED='\[\e[41m\]'   # Red
BAKGRN='\[\e[42m\]'   # Green
BAKYLW='\[\e[43m\]'   # Yellow
BAKBLU='\[\e[44m\]'   # Blue
BAKPUR='\[\e[45m\]'   # Purple
BAKCYN='\[\e[46m\]'   # Cyan
BAKWHT='\[\e[47m\]'   # White
TXTRST='\[\e[0m\]'    # Text Reset

PS1="┌─( $TXTGRN\u$TXTRST ) - ( $TXTPUR\d$TXTRST | $TXTPUR\@$TXTRST ) - ( $TXTCYN\w$TXTRST )\n└─$BLDRED command $TXTRST> "


##################
##	ALIAS	##
##################
alias fcache='fc-cache -vfs'
alias ..='cd ..'
alias pacman='sudo pacman-color'
alias clyde='sudo clyde'
alias orphan='pacman -Qdt'
alias bb='bauerbill'
alias gensums='[[ -f PKGBUILD ]] && makepkg -g >> PKGBUILD'
alias md5='md5sum'
alias a='aria2c'
alias ls='ls --group-directories-first --color=auto'
alias lsa='ls -a --group-directories-first --color=auto'
alias irc='urxvtc -name irssi -e irssi'
alias idt='urxvtc -name identica -e identicurse'
alias grep='grep --color'
alias nmr='sudo /etc/rc.d/networkmanager restart'
alias sf='screenfetch -s'
alias hset='hsetroot -fill'
alias kfc='killall conky'
alias off='sudo halt'
alias reboot='sudo reboot'
alias mount='sudo mount'
alias umount='sudo umount'
alias usb='mount /dev/sdb /mnt/usb'
alias fm='ranger'
alias nano='vim'
alias v='vim'
alias gcommit='git commit -m'
alias gpush='git push origin'
alias gadd='git add'

##########################
##	Compression	##
##########################
ex() {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}
