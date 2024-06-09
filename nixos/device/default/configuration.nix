{ config, pkgs, inputs, ... }:

{
imports = [
	./hardware-configuration.nix
	../../modules/audio.nix
	../../modules/virt.nix
	../../modules/network.nix
	../../modules/desktop.nix
	../../modules/gaming.nix
	../../modules/env.nix
];

nix.settings.experimental-features = [ "nix-command" "flakes" ];

boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;
boot.kernelPackages = pkgs.linuxPackages_6_9;

hardware.enableAllFirmware = true;

boot.initrd.luks.devices."luks-9e0fd976-102e-4697-95cc-903e91a49672".device = "/dev/disk/by-uuid/9e0fd976-102e-4697-95cc-903e91a49672";

# automount usb
services.devmon.enable = true;
services.udisks2.enable = true;

services.upower.enable = true;
services.power-profiles-daemon.enable = true;

services.fwupd.enable = true;
hardware.framework.amd-7040.preventWakeOnAC = true;

time.timeZone = "Europe/Berlin";
i18n.defaultLocale = "en_US.UTF-8";
i18n.extraLocaleSettings = {
	LC_ADDRESS = "de_DE.UTF-8";
	LC_IDENTIFICATION = "de_DE.UTF-8";
	LC_MEASUREMENT = "de_DE.UTF-8";
	LC_MONETARY = "de_DE.UTF-8";
	LC_NAME = "de_DE.UTF-8";
	LC_NUMERIC = "de_DE.UTF-8";
	LC_PAPER = "de_DE.UTF-8";
	LC_TELEPHONE = "de_DE.UTF-8";
	LC_TIME = "de_DE.UTF-8";
};

users.defaultUserShell = pkgs.zsh;
users.users.michael = {
	isNormalUser = true;
	description = "michael";
	shell = pkgs.zsh;
	extraGroups = [ "networkmanager" "wheel" ];
	packages = with pkgs; [
	];
};

nixpkgs.config.allowUnfree = true;

environment.systemPackages = with pkgs; [
] ++ (import ./../../modules/packages.nix pkgs);

programs.zsh = {
	enable = true;
	autosuggestions.enable = true;
};

system.stateVersion = "24.05"; # Did you read the comment?
}
