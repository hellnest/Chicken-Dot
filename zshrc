#!/bin/zsh

# Export
export EDITOR="vim"
export BROWSER="jumanji"

# Basic Configuration
autoload -U compinit 
autoload -U promptinit
autoload -U colors
autoload -U zrecompile
compinit
promptinit
colors

# Prompt
PROMPT="%{$fg_bold[red]%}%n%{$reset_color%} at %{$fg[magenta]%}%m %{$fg[yellow]%}%1~ %{$reset_color%}%#"
RPROMPT="[%{$fg[yellow]%}%?%{$reset_color%}]"

# Set Option
setopt AUTO_CD
setopt CORRECT
setopt AUTO_LIST
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt listtypes 
setopt interactivecomments
setopt correctall

# History Config
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
eval `dircolors -b`

# Zstyle
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' file-sort name
zstyle ':completion:*' glob 1
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' original true
zstyle ':completion:*' prompt 'correction: %e '
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1

# ALIAS
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
alias vs='sudo vim'
alias gcommit='git commit -m'
alias gpush='git push origin'
alias gadd='git add'
alias pid='pgrep'

# Functions
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
          *.tar.xz)    tar Jxf $1     ;; 
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}
