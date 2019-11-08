# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
if [ -e "$ZSH" ]; then
  plugins=(git ruby brew)
  source $ZSH/oh-my-zsh.sh
else
  echo "Did not find oh-my-zsh, make sure it's available."
fi

# History configuration
HISTSIZE=100000
SAVEHIST=100000

# jenv
if [ `command -v jenv` ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
PATH="$HOME/bin:$PATH"

# Python 3
# Homebrew installs of python3 do not override the unversioned python
# commands. Unversioned symlinks are installed into this folder:
HOMEBREW_PYTHON3=/usr/local/opt/python/libexec/bin
if [ -e $HOMEBREW_PYTHON3 ]; then
  PATH=$HOMEBREW_PYTHON3:$PATH
fi

# Python 3 virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

export PATH

export LESS="$LESS -XS"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=screen-256color

export ANDROID_HOME=/usr/local/opt/android-sdk

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Disables globbing, e.g. w/ ^ in HEAD^
unsetopt nomatch

# These are mostly for tmux in macOS.
alias rtun="reattach-to-user-namespace"
alias mvim="rtun mvim"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

. `brew --prefix`/etc/profile.d/z.sh

if [ `command -v rbenv` ]; then
  set_bundle_gemfile () {
    if [[ -f Gemfile.local ]]; then
      export BUNDLE_GEMFILE=Gemfile.local
    else
      unset BUNDLE_GEMFILE
    fi
  }

  eval "$(rbenv init -)"
  preexec_functions+=(set_bundle_gemfile)
fi

# nvm
NVM_DIR="$HOME/.nvm"
if [ -e "$NVM_DIR" ]; then
  export NVM_DIR
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
else
  echo "nvm not found?"
fi

# python 3 virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
if [ -e /usr/local/bin/virtualenvwrapper.sh ]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/martin/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/martin/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/martin/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/martin/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# directory specific .envrc files
if type "direnv" > /dev/null; then
  echo "Caution, direnv is hooked into shell"
  eval "$(direnv hook zsh)"
fi
