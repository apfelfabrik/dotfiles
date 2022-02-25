# zmodload zsh/zprof

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

export NVM_LAZY_LOAD=true

if [ -e "$ZSH" ]; then
  plugins=(git ruby brew zsh-nvm)
  source $ZSH/oh-my-zsh.sh
else
  echo "Did not find oh-my-zsh, make sure it's available."
fi

HISTSIZE=200000
SAVEHIST=200000

# jenv
if [ `command -v jenv` ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

# keg-only brews
PATH="/usr/local/opt/mysql-client/bin:$PATH"

PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
PATH="$HOME/bin:$PATH"
export PATH

export LESS="$LESS -XS"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=screen-256color



# Preferred editor for local and remote sessions
if [ `command -v vim` ]; then
  export EDITOR='vim'
else
  >&2 echo "Cannot find vim in PATH, EDITOR is '$EDITOR'"
fi

# Disables globbing, e.g. w/ ^ in HEAD^
unsetopt nomatch

# These are mostly for tmux in macOS.
alias rtun="reattach-to-user-namespace"
alias mvim="rtun mvim"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
#
if [ `command -v brew` ]; then
  . `brew --prefix`/etc/profile.d/z.sh
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

# More java things:
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_161.jdk/Contents/Home

# Husky is a liability
HUSKY_SKIP_HOOKS=1
HUSKY_SKIP_INSTALL=1

eval "$(pyenv init --path)"

PATH="/Users/martin/Library/Android/sdk/platform-tools:$PATH"
export ANDROID_SDK="/Users/martin/Library/Android/sdk"
export ANDROID_HOME=$ANDROID_SDK

. /usr/local/opt/asdf/libexec/asdf.sh

PATH="$HOME/.aha/bin:$PATH"
# eval $(aha autocomplete:script zsh)

# export KIND_EXPERIMENTAL_PROVIDER=podman

# zprof
