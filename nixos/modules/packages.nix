{ pkgs, ... }:

with pkgs; [
	# Extras
	xdg-user-dirs

	# Development
	gcc
	cargo
	lua
	neovim
	gh
	git
	nodejs
	go
	zsh
	zsh-autosuggestions

	# Utilities
	wget
	lf
	amdgpu_top
	file
	htop
	unzip
	zip
	yadm
	btop
	glxinfo
	lm_sensors
	vulkan-tools
	tldr
	usbutils
	pciutils
	v4l-utils
	libvdpau
	ddcutil
]

