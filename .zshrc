export LANG=en_US.UTF-8
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export GOPATH="$HOME/workspace/go"
export GOBIN="$GOPATH/bin/"
export PATH="$HOME/workspace/go/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
ZSH_THEME="robbyrussell"

# Set this for ssh connections to work when using alacritty
export TERM=xterm-256color

plugins=(git nvm sudo vi-mode zsh-autosuggestions)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

source $ZSH/oh-my-zsh.sh
pfetch
