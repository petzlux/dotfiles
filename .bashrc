# ~/.bashrc: executed by bash(1) for non-login shells.
export LESS='-q'
export EDITOR=vim

export HISTTIMEFORMAT="%F %T "

if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform        
    export LS_OPTIONS='-GAt'
    if which brew >/dev/null; then
        if [ -f `brew --prefix`/etc/bash_completion ]; then
            . `brew --prefix`/etc/bash_completion
        fi
    fi
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under Linux platform
    export LS_OPTIONS='-GAt --color'
    source /usr/share/git-core/contrib/completion/git-prompt.sh
    eval $(dircolors -b .dircolors/LS_COLORS)
fi

export HISTCONTROL=ignoredups
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


export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$(__git_ps1)\$ "
export CLICOLOR=1

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
