# zmodload zsh/zprof

autoload -Uz compinit && compinit

# Completion menu with highlighting
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Partial/substring word completion (e.g. `cd dbt<tab>` matches `ds-dbt`)
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Emacs keybindings (previously provided by oh-my-zsh)
bindkey -e

# ^[[Z is shift-tab
bindkey '^[[Z' reverse-menu-complete

# Disables globbing, e.g. w/ ^ in HEAD^
unsetopt nomatch

setopt SHARE_HISTORY

setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

HISTSIZE=340000
SAVEHIST=340000
HISTFILE=~/.zsh_shared_history

if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# enable rupa/z
Z_PATH="${HOMEBREW_PREFIX:-/opt/homebrew}/etc/profile.d/z.sh"
if [[ -f "$Z_PATH" ]]; then
  source "$Z_PATH"
fi

# directory specific .envrc files
if type "direnv" &> /dev/null; then
  echo "Caution, direnv is hooked into shell"
  eval "$(direnv hook zsh)"
fi

# Google Cloud SDK: PATH, then command completion
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi

# Shared shell configuration (nvm, editor, PATH, aliases, etc.)
. ~/.shrc
export PATH="$HOME/.local/bin:$PATH"
typeset -U path fpath
