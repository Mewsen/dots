# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

[[ $- != *i* ]] && return

# Enable colors
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias ls='ls --color=auto'

alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias adb='HOME="$XDG_DATA_HOME/android" adb'
alias monerod='monerod --data-dir "$XDG_DATA_HOME/bitmonero"'

# fix forward search (<C-S>)
stty -ixon

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc

eval "$(direnv hook bash)"

# pnpm
export PNPM_HOME="/home/michael/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

mkdir -p "$XDG_RUNTIME_DIR/keychain"
chmod -R go-rwx "$XDG_RUNTIME_DIR/keychain"
eval $(keychain --absolute --dir="$XDG_RUNTIME_DIR/keychain" --systemd --eval --quiet ~/.ssh/michael)
