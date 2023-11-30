export LANG=en_US.UTF-8

export PATH="$HOME/.cargo/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/workspace/go/bin:$PATH"
export GOPATH="$HOME/workspace/go"
export EDITOR='nvim'

ZSH_THEME="robbyrussell"

plugins=(git sudo vi-mode zsh-autosuggestions)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

source $ZSH/oh-my-zsh.sh
source /usr/share/nvm/init-nvm.sh
export PATH=$PATH:/home/mewsen/.spicetify
