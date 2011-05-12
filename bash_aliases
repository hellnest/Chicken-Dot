#!/bin/bash

# Alias
alias s='sudo'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ds='find $(pwd -P) -maxdepth 1 -type d -exec du -sh {} + 2>/dev/null | sort -h'
alias pacman='sudo pacman-color'
alias pactree='pactree -c'
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
alias vp='vim PKGBUILD'
alias vs='sudo vim'
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
alias tree='tree -CA'
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias :q='exit'

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
    [[ $1 ]] || return 0
    [[ ! -d $1 ]] && mkdir -vp "$1"
    [[ -d $1 ]] && builtin cd "$1"
}

cwd() {
  cower -df $1 && cd $1
}

maketpkg() {
  makepkg --config /home/lee/terralinux/script/makepkg.terra -rsc [[ -f PKGBUILD ]] && rm -rf *.pkg.*
}

build-system() {
  sudo mkarchroot -f -u -C ~/terralinux/repository/build/pacman.chroot -M ~/terralinux/repository/build/makepkg.chroot ~/terralinux/repository/build/root $1 || return 0
}

ghremote() {
  mkdir -p $2 && cd $2 && git init
  git remote add origin git@github.com:$1/$2.git
}

unsvn() {
  if [[ -z $1 ]]; then
echo "USAGE: unwork <dirname>"
    return 1
  fi

if [[ -d $1 ]]; then
local count
    read count < <(find "$1" -type d -name '.svn' -printf 'foo\n' -exec rm -rf {} + | wc -l)
    if [[ $? != 0 ]]; then
echo "Error occurred. Nothing done." >&2
    elif [[ $count = 0 ]]; then
echo "Nothing done."
    else
echo "SUCCESS. Directory is no longer a working copy ($count .svn removed)."
    fi
else
echo "ERROR: $1 is not a directory"
  fi
}

depscan() {
  [[ -z $1 ]] && { echo "usage: depscan <package>"; return; }
  while read elfobj; do
readelf -d $elfobj | sed -n 's|.*NEEDED.*\[\(.*\)\].*|'$elfobj' -- \1|p'
  done < <(file $(pacman -Qlq $1) | sed -n '/ELF/s/^\(.*\):.*/\1/p') | nl
}

deps() {
  local prog
  if [[ -f "$1" ]]; then
prog=$1
  else
prog=$(type -P $1)
    echo -e "$1 => $prog\n"
  fi

  [[ -z $prog ]] && { echo "File not found"; return 1; }
  readelf -d $prog | sed -n '/NEEDED/s/.* library: \[\(.*\)\]/\1/p'
}
## Services Functions
stop() {
  sudo /etc/rc.d/$1 stop
}

start() {
  sudo /etc/rc.d/$1 start
}

restart() {
  sudo /etc/rc.d/$1 restart
}

# GIT Functions
function git_info() {
    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        # print informations
        echo "git repo overview"
        echo "-----------------"
        echo

        # print all remotes and thier details
        for remote in $(git remote show); do
echo $remote:
            git remote show $remote
            echo
done

        # print status of working repo
        echo "status:"
        if [ -n "$(git status -s 2> /dev/null)" ]; then
git status -s
        else
echo "working directory is clean"
        fi

        # print at least 5 last log entries
        echo
echo "log:"
        git log -5 --oneline
        echo

else
echo "you're currently not in a git repository"

    fi
}

translate(){
if [[ -z $1 ]]; then
echo "USAGE: translate <phrase> <source-language> <output-language>"
    return 1
fi 
  wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'; 
}

# vim: syn=sh ft=sh et
