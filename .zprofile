#!/bin/sh

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export WORKSPACE="$HOME/Workspace"
export PERSONAL="$HOME/Personal"

# Path
export PATH="$HOME/.local/bin:$PATH"

# Docker
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

# Rust
export CARGO_HOME="$WORKSPACE/cargo"
export RUSTUP_HOME="$WORKSPACE/rustup"
export PATH="$WORKSPACE/cargo/bin:$PATH"

# Go
export PATH="$WORKSPACE/go/bin:$PATH"
export GOPATH="$WORKSPACE/go"
export GOBIN="$GOPATH/bin/"

# Zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"


export LANG=en_US.UTF-8
export EDITOR='nvim'

export TERM=xterm-256color



