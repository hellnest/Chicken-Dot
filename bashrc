# Bash Configuration
# Author    : Martin Lee
# License   : As it is

# Check for interactive Session
[[ $- != *i* ]] && return
# Fallback PS1
PS1='[\W]\$ '
 
complete -cf sudo
complete -cf man

# Shell opts
shopt -s cdspell dirspell globstar histverify no_empty_cmd_completion

# Ext Config
[[ -r ~/.dircolors && -x /bin/dircolors ]] && eval $(dircolors -b ~/.dircolors)
[[ -r ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -z $BASH_COMPLETION && -r /etc/bash_completion ]] && . /etc/bash_completion

# Tmux Color
[ -n "$TMUX" ] && export TERM=screen-256color

# bash 4 features
if [[ ${BASH_VERSINFO[0]} -ge 4 ]]; then
  shopt -s globstar
  shopt -s autocd
fi

shopt -s checkwinsize
shopt -s extglob

set -o notify           # notify background job
ulimit -S -c 0          # Disable core dumps
stty -ctlecho           # turn off control character echoing
setterm -regtabs 2      # set tab width of 4 ( TTY Only )
_expand() { return 0; } # disable tidle expansion

# more for less
LESS=-R # use -X to avoid sending terminal initialization
LESS_TERMCAP_mb=$'\e[01;31m'
LESS_TERMCAP_md=$'\e[01;31m'
LESS_TERMCAP_me=$'\e[0m'
LESS_TERMCAP_se=$'\e[0m'
LESS_TERMCAP_so=$'\e[01;44;33m'
LESS_TERMCAP_ue=$'\e[0m'
LESS_TERMCAP_us=$'\e[01;32m'
export ${!LESS@}

# history
HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*"
HISTCONTROL="ignoreboth:erasedups"
HISTSIZE=1000
HISTFILESIZE=2000
export ${!HIST@}

# chroot prompt
if [[ -f $HOME/.chroot ]]; then
   root_name=$(< $HOME/.chroot)
   root_name=${root_name:-NONAME}
   PS1='[\u@\h${root_name} \w]\$ '
   return
fi

prompt_command () {
    local rts=$?
    local w=$(echo "${PWD/#$HOME/~}" | sed 's/.*\/\(.*\/.*\/.*\)$/\1/') # pwd max depth 3
# pwd max length L, prefix shortened pwd with m
    local L=30 m='<'
    [ ${#w} -gt $L ] && { local n=$((${#w} - $L + ${#m}))
    local w="\[\033[0;32m\]${m}\[\033[0;37m\]${w:$n}\[\033[0m\]" ; } \
    ||   local w="\[\033[0;37m\]${w}\[\033[0m\]"
# different colors for different return status
    [ $rts -eq 0 ] && \
    local p="\[\033[1;30m\]>\[\033[0;32m\]>\[\033[1;32m\]>\[\033[m\]" || \
    local p="\[\033[1;30m\]>\[\033[0;31m\]>\[\033[1;31m\]>\[\033[m\]"
    PS1="${w} ${p}\$(__git_ps1 ' \[\e[0;32m\]%s\[\e[0m\]') " 
    PS4='+$BASH_SOURCE:$LINENO:$FUNCNAME: ' 
}

PROMPT_COMMAND=prompt_command
GIT_PS1_SHOWDIRTYSTATE=yes

eval $( keychain --eval id_rsa )
source /etc/profile
# vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=sh:
