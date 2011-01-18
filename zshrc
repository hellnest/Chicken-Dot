# utf-8 in the terminal, will break stuff if your term isn't utf aware
LANG=en_US.UTF-8 
LC_ALL=$LANG
LC_COLLATE=C

# Export
export EDITOR="vim"
export VISUAL="vim"
export BROWSER="luakit"

# Basic Configuration
autoload -U compinit 
autoload -U colors
autoload edit-command-line
autoload -U zmv
compinit
colors

REPORTTIME=60       # Report time statistics for progs that take more than a minute to run
WATCH=notme         # Report any login/logout of other users
WATCHFMT='%n %a %l from %m at %T.'

# Prompt
PROMPT='%{$fg[red]%}(%n)%{$reset_color%} %{$fg_bold[yellow]%}➜%{$reset_color%} %{$fg[magenta]%}%M %~ %{$reset_color%}%# '
RPROMPT='%{$fg[white]%}%m%{$reset_color%}'

# Set Option
setopt                          \
        auto_cd                 \
        auto_pushd              \
	append_history		\
        chase_links             \
        noclobber               \
        complete_aliases        \
        extended_glob           \
        hist_ignore_all_dups    \
        hist_ignore_space       \
        ignore_eof              \
        share_history           \
        no_flow_control         \
        list_types              \
        mark_dirs               \
        path_dirs               \
        prompt_percent          \
        prompt_subst            \
        rm_star_wait

# Push a command onto a stack allowing you to run another command first
bindkey '^J' push-line

# History Config
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
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
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' original true
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
alias df='df -h'
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
# Compression #
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


