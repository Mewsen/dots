export LANG=en_US.UTF-8
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export GOPATH="$HOME/workspace/go"
export GOBIN="$GOPATH/bin/"
export PATH="$HOME/workspace/go/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
ZSH_THEME="robbyrussell"

plugins=(git nvm sudo vi-mode zsh-autosuggestions)

alias code='codium --password-store="gnome-libsecret" && exit'

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

source $ZSH/oh-my-zsh.sh
pfetch
