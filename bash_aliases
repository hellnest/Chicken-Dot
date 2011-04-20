#!/bin/bash

# Alias
alias s='sudo'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias pacman='sudo pacman'
alias pacoptimize='sudo pacman-optimize'
alias ifconfig='sudo ifconfig'
alias iwconfig='sudo iwconfig'
alias mount='sudo mount'
alias umount='sudo umount'
alias ls='ls --group-directories-first --color'
alias la='ls -a --color=auto'
alias ll='ls -hl --group-directories-first --color'
alias lla='ls -hla --group-direcotires-first --color'
alias grep='grep --color'
alias diff='colordiff'
alias reboot='sudo shutdown -r now'
alias refsck='sudo shutdown -rF now'
alias off='sudo shutdown -h now'
alias v='vim'
alias vs='sudo vim'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gp='git push'
alias gl='git pull'
alias gadd='git add'
alias pid='pgrep'
alias df='df -h'
alias free='free -m'
alias gensums='[[ -f PKGBUILD ]] && makepkg -g >> PKGBUILD'
alias mkchpkg='sudo makechrootpkg -c -r'
alias tmux='tmux attach'
alias :q='exit'

# SSH
alias terra='ssh hellnest@ssh.supremecenter300.com'

# Packaging
#alias maketpkg='makepkg --config /home/terralinux/script/makepkg.terra -rsc'
# Functions
ex() {
    if [[ -f $1 ]]; then
    case $1 in
    *.tar.@(bz2|gz|xz))  tar xvf $1     ;;
    *.@(tar|tbz2|tgz))   tar xvf $1     ;;
    *.bz2)               bunzip2 $1     ;;
    *.rar)               unrar x $1     ;;
    *.gz)                gunzip $1      ;;
    *.lzma)              unxz $1        ;;
    *.rpm)               bsdtar xf $1   ;;
    *.zip)               unzip $1       ;;
    *.Z)                 uncompress $1  ;;
    *.7z)                7z x $1        ;;
    *.exe)               cabextract $1  ;;
    *)                   echo "'$1': unrecognized file compression" ;;
        esac
    else
    echo "'$1' is not a valid file"
    fi
}

ghclone() {                                                                     
  (( $# == 2 )) || return 1                                                     
  git clone git://github.com/$1/${2%.git}.git                                   
}

take() {
  mkdir -p $1 && cd $1
}

cwd() {
  cower -d $1 && cd $1
}

maketpkg() {
  makepkg --config /home/lee/terralinux/script/makepkg.terra -rsc [[ -f PKGBUILD ]] && rm -rf *.xz
}

ghremote() {
  mkdir -p $2 && cd $2 && git init
  git remote add origin git@github.com:$1/$2.git
}

# vim: syn=sh ft=sh et
