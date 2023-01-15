# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix


      ./lib/home.nix

      ./pkgs/grub-theme.nix
    ];

  # Bootloader.

  boot = {
    cleanTmpDir = true;

    loader = {
    	efi = {
	    canTouchEfiVariables = true;
	    efiSysMountPoint = "/boot/efi";
	};
    	grub = {
            enable = true;
            version = 2;
            useOSProber = true;
            device = "nodev";
	    efiSupport = true;
	};
    };
  };

  #steam fixes
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;

  # audio
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;    ## If compatibility with 32-bit applications is desired.
  #nixpkgs.config.pulseaudio = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

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

  virtualisation.docker.enable = true;

  # Configure keymap in X11
  services.xserver = {
    enable = true;

    layout = "de";
    xkbVariant = "";

    videoDrivers = [ "nvidia" ];

    dpi = 96;

    displayManager = {
    	sddm.enable = true;
        sddm.theme = "sugar-dark";
        defaultSession = "none+awesome";
        
        setupCommands = "xrandr --output HDMI-1 --mode 1920x1080 --pos 1920x0 --output DP-0 --mode 1920x1080 --pos 0x0";
    };

    libinput = {
        enable = true;
        touchpad = {
            naturalScrolling = false;
            middleEmulation = false;
            tapping = true;
        };
    };

    windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
            luarocks
            vicious
        ];
    };
  };

  # nvidia driver
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.simon = {
    isNormalUser = true;
    description = "Simon";
    extraGroups = [ "networkmanager" "wheel" "audio" "sound" "video" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };
 
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "CascadiaCode" "JetBrainsMono" "Iosevka" ]; })
  ];

  environment.variables = {
    GDK_SCALE = "1";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	neovim
	wget
	kitty
	firefox

    maim
    notify-desktop
	
	git

	gitkraken
	chromium
	picom

	cinnamon.nemo

    gparted
    inkscape
    gimp
    spotify
    steam
    
    cura
    openscad

    discord

    postman
    termius
    mongodb-compass

    bitwarden
    onlyoffice-bin

    docker

    jetbrains.webstorm
    jetbrains.idea-ultimate
    jetbrains.datagrip

    nodejs-16_x
    openjdk18-bootstrap

	pavucontrol

	zsh-syntax-highlighting
	zsh-autosuggestions
	zsh-powerlevel10k

	# awesome
	rofi
	playerctl
    xdg-user-dirs

    tdesktop

    # epiphany
    midori


    # required for neovim
    gcc
    python2
    python39
    unzip
    xclip
    ripgrep
    # lsp
    sumneko-lua-language-server

    rclone

	# sddm libraries
	libsForQt5.qt5.qtgraphicaleffects
	libsForQt5.qt5.qtquickcontrols

	# custom packages
	(import ./pkgs/sddm-theme.nix)
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.dconf.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
