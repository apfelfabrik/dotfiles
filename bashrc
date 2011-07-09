# ~/.bashrc: executed by bash(1) for non-login shells.

# return if not running interactively.
[ -z "$PS1" ] && return

function path {

  # adding an appropriate PATH variable for use with MacPorts.
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH

  # ruby & jruby stuff
  PATH=/opt/jruby/bin:$PATH
  PATH=/opt/glassfish/bin:$PATH
  PATH=/opt/local/lib/postgresql83/bin:$PATH
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

  export JRUBY_HOME=/opt/jruby
  for f in $JRUBY_HOME/bin/*; do
    f=$(basename $f)
    case $f in jruby*|jirb*|*.bat|*.rb|_*) continue ;; esac
    eval "alias j$f='jruby -S $f'"
  done

  # vim stuff
  if [ -z "$MACVIM_APP_DIR" ]; then
    for p in ${PATH//:/$'\n'}; do
      if [ -x "$p/mvim" ]; then
        MACVIM_APP_DIR="$p"; break
      fi
    done
  fi
  if [ -z "$MACVIM_APP_DIR" ]; then
    # when no mvim was found, map mvim to gvim for convenience.
    # this should probably include diff view and ex.
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
  
  # java stuff
  alias soy='export JAVA_HOME="/opt/soylatte16" && export PATH="/opt/soylatte16/bin:$PATH" && export PS1="SOY: $PS1"'
}

function bash_options {

  # vi mode
  set -o vi

  shopt -s checkwinsize

  shopt -s histappend
  export PROMPT_COMMAND='history -a'

  # bash-completion
  export USER_BASH_COMPLETION_DIR=~/.bash_completion.d
  if [ -f /opt/local/etc/bash_completion ]; then
      . /opt/local/etc/bash_completion # darwin
  fi
  if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion # debian
  fi

}

function prompt {

  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
      xterm-color) color_prompt=yes;;
  esac
  
  # uncomment for a colored prompt
  #force_color_prompt=yes
  
  if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      # We have color support; assume it's compliant with Ecma-48
      # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
      # a case would tend to support setf rather than setaf.)
      color_prompt=yes
    else
      color_prompt=
    fi
  fi
  
  if [ "$color_prompt" = yes ]; then
    export COLOR_NC='\e[0m' # No Color
    export COLOR_WHITE='\e[1;37m'
    export COLOR_BLACK='\e[0;30m'
    export COLOR_BLUE='\e[0;34m'
    export COLOR_LIGHT_BLUE='\e[1;34m'
    export COLOR_GREEN='\e[0;32m'
    export COLOR_LIGHT_GREEN='\e[1;32m'
    export COLOR_CYAN='\e[0;36m'
    export COLOR_LIGHT_CYAN='\e[1;36m'
    export COLOR_RED='\e[0;31m'
    export COLOR_LIGHT_RED='\e[1;31m'
    export COLOR_PURPLE='\e[0;35m'
    export COLOR_LIGHT_PURPLE='\e[1;35m'
    export COLOR_BROWN='\e[0;33m'
    export COLOR_YELLOW='\e[1;33m'
    export COLOR_GRAY='\e[0;30m'
    export COLOR_LIGHT_GRAY='\e[0;37m'
    export CLICOLOR="YES"
    alias colorslist="set | egrep 'COLOR_\w*'"  # lists all the colors
  
    PS1="${debian_chroot:+($debian_chroot)}\[$COLOR_GREEN\]\u@\h\[$COLOR_NC\]:\[$COLOR_BLUE\]\w\[$COLOR_NC\]\$ "
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi
  unset color_prompt force_color_prompt
  
  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
  xterm*|rxvt*)
      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
      ;;
  *)
      ;;
  esac
}

path
environment
bash_options
prompt

