# zmodload zsh/zprof

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

if [ -e "$ZSH" ]; then
  plugins=(git ruby)
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

# enable rupa/z
if command -v brew &> /dev/null; then
  Z_PATH="$(brew --prefix)/etc/profile.d/z.sh"
  if [[ -f "$Z_PATH" ]]; then
    source "$Z_PATH"
  fi
fi

# directory specific .envrc files
if type "direnv" &> /dev/null; then
  echo "Caution, direnv is hooked into shell"
  eval "$(direnv hook zsh)"
fi

# # The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi

# # The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi

# Shared shell configuration (nvm, editor, PATH, aliases, etc.)
. ~/.shrc
