. .secrets

# vi mode
set -o vi

# MacPorts Installer addition: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# bash-completion
export USER_BASH_COMPLETION_DIR=~/.bash_completion.d
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# vim stuff
EDITOR=vim; export EDITOR
function gvim { /Applications/MacVim.app/Contents/MacOS/Vim -g $*; }
alias mvim='gvim'

# bash history fine-tuning
export HISTCONTROL=erasedumps
export HISTSIZE=10000
shopt -s histappend

# java stuff
alias soy='export JAVA_HOME="/opt/soylatte16" && export PATH="/opt/soylatte16/bin:$PATH" && export PS1="SOY: $PS1"'

# ruby & jruby stuff
PATH=/opt/jruby/bin:$PATH
PATH=/opt/glassfish/bin:$PATH
PATH=/opt/local/lib/postgresql83/bin:$PATH
export PATH

export JRUBY_HOME=/opt/jruby
for f in $JRUBY_HOME/bin/*; do
  f=$(basename $f)
  case $f in jruby*|jirb*|*.bat|*.rb|_*) continue ;; esac
  eval "alias j$f='jruby -S $f'"
done
