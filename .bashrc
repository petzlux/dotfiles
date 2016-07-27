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
    # source /usr/share/git-core/contrib/completion/git-prompt.sh
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

alias ssh-tunnels-kill='ps aux | grep "ssh" | grep "\-f" | awk '\''{print $2}'\'' | xargs kill'
alias ssh-tunnels='ps aux | grep "ssh" | grep "\-f"'

if [ `id -u` -eq 0 ]; then
  export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/bin/X11:/usr/games"
fi
# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
   PATH=~/bin:"${PATH}"
fi

if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

if [ -f ~/.bashrc_after ]; then
    source ~/.bashrc_after
fi

export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)




export NVM_DIR="/home/wepa/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
