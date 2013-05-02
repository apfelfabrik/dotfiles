# ~/.bashrc: executed by bash(1) for non-login shells.

# return if not running interactively.
[ -z "$PS1" ] && return

export COLOR_NC='\[\e[0m\]' # No Color
export COLOR_WHITE='\[\e[1;37m\]'
export COLOR_BLACK='\[\e[0;30m\]'
export COLOR_BLUE='\[\e[0;34m\]'
export COLOR_LIGHT_BLUE='\[\e[1;34m\]'
export COLOR_GREEN='\[\e[0;32m\]'
export COLOR_LIGHT_GREEN='\[\e[1;32m\]'
export COLOR_CYAN='\[\e[0;36m\]'
export COLOR_LIGHT_CYAN='\[\e[1;36m\]'
export COLOR_RED='\[\e[0;31m\]'
export COLOR_LIGHT_RED='\[\e[1;31m\]'
export COLOR_PURPLE='\[\e[0;35m\]'
export COLOR_LIGHT_PURPLE='\[\e[1;35m\]'
export COLOR_BROWN='\[\e[0;33m\]'
export COLOR_YELLOW='\[\e[1;33m\]'
export COLOR_GRAY='\[\e[0;30m\]'
export COLOR_LIGHT_GRAY='\[\e[0;37m\]'
export CLICOLOR="YES"
# alias list_colors="set | egrep '^COLOR_\w*'"  # lists all the colors

function path {

  # general
  PATH=/usr/local/sbin:$PATH
  PATH=/usr/local/bin:$PATH

  # macports
  PATH=/opt/local/bin:$PATH
  PATH=/opt/local/sbin:$PATH
  PATH=/opt/local/lib/postgresql83/bin:$PATH
  PATH=/opt/local/apache2/bin:$PATH

  # other
  PATH=/usr/texbin:$PATH
  PATH=/opt/glassfish/bin:$PATH

  export PATH
}

function environment {

  # load any secrets that shouldn't be shared on github.
  source $HOME/.secrets

  # This loads RVM into a shell session.
  [[ -s "/Users/martin/.rvm/scripts/rvm" ]] && source "/Users/martin/.rvm/scripts/rvm"

  # bash history
  export HISTCONTROL=ignoreboth
  export HISTTIMEFORMAT='%F %T '
  export HISTSIZE=262144 # 0x40000

  # vim stuff
  if [[ -z "$MACVIM_APP_DIR" ]]; then
    for p in ${PATH//:/$'\n'}; do
      if [[ -x "$p/mvim" ]]; then
        MACVIM_APP_DIR="$p"; break
      fi
    done
  fi
  if [[ -z "$MACVIM_APP_DIR" ]]; then
    # when no mvim was found, map mvim to gvim for convenience.
    alias mvim="gvim"
  else
    # create mvim toolset with aliases.
    alias mvimdiff="$p/mvim"
    alias mex="$p/mvim"
    alias rmvim="$p/mvim"
    # turn vim toolset into mvim toolset aliases.
    alias vim="mvim"
    alias vimdiff="mvimdiff"
    alias view="mview"
    alias ex="mex"
    alias rvim="rmvim"
  fi

  function gvim { /Applications/MacVim.app/Contents/MacOS/Vim -g $*; }

  EDITOR=vim; export EDITOR

  # lists
  alias ls='ls -G'
  alias ll='ls -l'
  alias la='ls -la'

  # rails
  alias ss='./script/server'
  alias sc='./script/console'
  alias sr='./script/runner'

  # other
  alias find='find -L'
  alias http='python -m SimpleHTTPServer'
}

function bash_options {

  # vi mode
  set -o vi

  shopt -s checkwinsize
  shopt -s histappend

  # bash-completion
  export USER_BASH_COMPLETION_DIR=~/.bash_completion.d
  if [[ -f /opt/local/etc/bash_completion ]]; then
      . /opt/local/etc/bash_completion # darwin
  fi
  if [[ -f /etc/bash_completion ]]; then
      . /etc/bash_completion # debian
  fi

}

function prompt {

  # Show last commands exit-code by smiley
  if [ $? = 0 ]; then
    EXITCODE="${COLOR_GREEN}✔ "
  else
    EXITCODE="${COLOR_RED}✘ "
  fi
  EXITCODE="$EXITCODE${COLOR_NC}"

  # append immediately after each command.
  history -a
  # this refreshes after each command,
  # but turns out to be rather annoying.
  # history -n

  PS1="${debian_chroot:+($debian_chroot)}"

  USER=$(whoami)
  if [ -z $HOSTNAME ]; then
    export HOSTNAME=`hostname -s`
  fi

  # SHOW RUBY VERSION
  if (which rvm-prompt 2>&1 > /dev/null); then
    RUBY="\$(rvm-prompt i v g)"
  else
    if (which rbenv 2>&1 > /dev/null); then
      RUBY="\$(rbenv version-name)"
    fi
  fi

  PS1="$EXITCODE${PS1}${COLOR_YELLOW}\u@\h${COLOR_NC}:${COLOR_RED}${RUBY}${COLOR_NC}:${COLOR_BLUE}\w${COLOR_NC}\$ "
}

path
environment
bash_options

PROMPT_COMMAND=prompt

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
