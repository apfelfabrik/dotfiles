eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ `command -v jenv` ]]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

if [[ -s "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  . "$HOME/.rvm/scripts/rvm"
fi

if [[ `command -v rbenv` ]]; then
  eval "$(rbenv init - zsh)"
fi

if [[ `command -v pyenv` ]]; then
  eval "$(pyenv init --path)"
fi
