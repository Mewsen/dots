{pkgs, ...}:
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
  unstable.go
  zsh
  zsh-autosuggestions

  # Utilities
  hugo
  wget
  lf
  amdgpu_top
  file
  htop
  unzip
  zip
  yadm
  btop
  #nix fmt
  alejandra
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
