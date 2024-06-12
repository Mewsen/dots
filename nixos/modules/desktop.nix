{config, pkgs, ...}:

{	
    services.logind = {
	lidSwitch = "suspend-then-hibernate";
	lidSwitchExternalPower = "ignore";
	extraConfig = ''
	    HandlePowerKey=suspend-then-hibernate
	    IdleAction=suspend-then-hibernate
	    IdleActionSec=2m
	    '';
    };

    systemd.sleep.extraConfig = "HibernateDelaySec=1h";

    # Whether to enable i2c devices support.
    hardware.i2c.enable = true;

    #Provides an interface to sensors like Accelerometers and Light sensors. 
    hardware.sensor.iio.enable = true;
    
    #bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
      hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

    services.xserver.videoDrivers = [ "modesettings" ];

    hardware.opengl = {
	enable = true;
	driSupport = true;
	driSupport32Bit = true;
	extraPackages = with pkgs; [ 
	    mesa
	    libva
	    amdvlk
	];
	extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };

    security.polkit.enable = true;

    services.printing.enable = true;

    fonts.packages = with pkgs; [
	noto-fonts
	noto-fonts-cjk
	noto-fonts-emoji
	liberation_ttf
	(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
	mplus-outline-fonts.githubRelease
	dina-font
	proggyfonts
    ];

    services.gnome.gnome-keyring.enable = true;
    programs.dconf.enable = true;
    security.pam.services.swaylock = {
	fprintAuth = false;
    };

    environment.systemPackages = with pkgs; [
	power-profiles-daemon
	kdePackages.kate
	sway
	swayidle
	swaylock
	alacritty
	bemenu
	networkmanagerapplet
	grim
	waybar
	polkit
	polkit_gnome
	wev
	xdg-desktop-portal-wlr
	brightnessctl
	slurp
	wl-clipboard
	mako
	pavucontrol
	#firefox-bin
	(pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})
	libreoffice
	signal-desktop
	spotify
	xwayland
	libva-utils
	vesktop
	gnome.nautilus
	gnome.adwaita-icon-theme
	obsidian
	vscode
	halloy
	wl-color-picker
	kdePackages.kdenlive
    	#For xembedsniproxy which embeds xtrays for wayland systemtray 
    	libsForQt5.plasma-workspace
	(
    writeTextFile {
	    name = "initsway";
	    destination = "/bin/initsway";
	    executable = true;

	    text = ''
		    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
		    '';
    }
    )

    ];

    services.desktopManager.plasma6.enable = true;
    programs.firefox.enable = true;
    programs.sway.enable = true;
    programs.waybar.enable = true;
    services.dbus.enable = true;

    xdg = {
	portal = {
	    enable = true;
	    extraPortals = with pkgs; [
		xdg-desktop-portal-wlr
	    ];
	};
	mime.enable = true;
    };
}
