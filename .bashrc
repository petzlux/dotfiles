# ~/.bashrc: executed by bash(1) for non-login shells.
export LESS='-q'
export EDITOR=vim

export HISTTIMEFORMAT="%F %T "

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='-GAt'
export HISTCONTROL=ignoredups
#eval `dircolors`
alias ls='ls $LS_OPTIONS'
alias l='ls $LS_OPTIONS -Fahl'

# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias webserver='python -m SimpleHTTPServer 8081'

if [ `id -u` -eq 0 ]; then
  export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/bin/X11:/usr/games"
fi
# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
   PATH=~/bin:"${PATH}"
fi

if [ -f /etc/bash_completion.d/git ]; then
  . /etc/bash_completion.d/git
fi

if [ -f ~/.bashrc_after ]; then
    source ~/.bashrc_after
fi

if which brew >/dev/null; then
    if [ -f `brew --prefix`/etc/bash_completion ]; then
        . `brew --prefix`/etc/bash_completion
    fi
fi

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1)\$ '
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
