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

alias ssh-tunnels-kill='ps aux | grep "ssh" | grep "\-f" | awk '\''{print $2}'\'' | xargs kill'
alias ssh-tunnels='ps aux | grep "ssh" | grep "\-f"'

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


# following taken from https://github.com/henrik/dotfiles/blob/master/bash/prompt.sh

function __git_prompt {
  GIT_PS1_SHOWDIRTYSTATE=1
  [ `git config user.pair` ] && GIT_PS1_PAIR="`git config user.pair`@"
  __git_ps1 " $GIT_PS1_PAIR%s" | sed 's/ \([+*]\{1,\}\)$/\1/'
}

# Only show username@server over SSH.
function __name_and_server {
  echo "`whoami`@`hostname -s` "
}

bash_prompt() {

  # regular colors
  local K="\[\033[0;30m\]"    # black
  local R="\[\033[0;31m\]"    # red
  local G="\[\033[0;32m\]"    # green
  local Y="\[\033[0;33m\]"    # yellow
  local B="\[\033[0;34m\]"    # blue
  local M="\[\033[0;35m\]"    # magenta
  local C="\[\033[0;36m\]"    # cyan
  local W="\[\033[0;37m\]"    # white

  # emphasized (bolded) colors
  local BK="\[\033[1;30m\]"
  local BR="\[\033[1;31m\]"
  local BG="\[\033[1;32m\]"
  local BY="\[\033[1;33m\]"
  local BB="\[\033[1;34m\]"
  local BM="\[\033[1;35m\]"
  local BC="\[\033[1;36m\]"
  local BW="\[\033[1;37m\]"

  # reset
  local RESET="\[\033[0;37m\]"

  PS1="$BY\$(__name_and_server)$Y\W$G\$(__git_prompt)$RESET$ "

}

bash_prompt
unset bash_prompt
