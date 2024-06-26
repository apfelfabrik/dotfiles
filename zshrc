# zmodload zsh/zprof

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"

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
  # plugins=(git ruby brew zsh-nvm)
  plugins=(git ruby zsh-nvm)
  source $ZSH/oh-my-zsh.sh
else
  echo "Did not find oh-my-zsh, make sure it's available."
fi

# Disables globbing, e.g. w/ ^ in HEAD^
unsetopt nomatch

setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_BEEP

HISTSIZE=340000
SAVEHIST=340000
HISTFILE=~/.zsh_shared_history

eval "$(starship init zsh)"

export LESS="$LESS -XS"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color

# Preferred editor for local and remote sessions
if [ `command -v vim` ]; then
  export EDITOR='vim'
else
  >&2 echo "Cannot find vim in PATH, EDITOR is '$EDITOR'"
fi

# enable rupa/z
if [ `command -v brew` ]; then
  source `brew --prefix`/etc/profile.d/z.sh
fi

# directory specific .envrc files
if type "direnv" > /dev/null; then
  echo "Caution, direnv is hooked into shell"
  eval "$(direnv hook zsh)"
fi

# Husky is a liability
HUSKY_SKIP_HOOKS=1
HUSKY_SKIP_INSTALL=1
HUSKY=0

. ~/.secrets
