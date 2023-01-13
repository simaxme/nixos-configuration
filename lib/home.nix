{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.simon = {
    home.stateVersion = "22.11";

    home.file.".config/kitty".source = ../dotfiles/kitty;
    # home.file.".config/nvim".source = ../dotfiles/nvim;
    home.file.".config/picom".source = ../dotfiles/picom;
    home.file.".config/awesome".source = ../dotfiles/awesome;
    home.file.".config/rofi".source = ../dotfiles/rofi;

    home.file.".Xresources".source = ../dotfiles/.Xresources;
    home.file.".ideavimrc".source = ../dotfiles/.ideavimrc;

    gtk.enable = true;
    gtk.theme.name = "Dracula";
    gtk.theme.package = pkgs.dracula-theme;

    gtk.iconTheme.name = "WhiteSur";
    gtk.iconTheme.package = pkgs.whitesur-icon-theme;
  
    gtk.cursorTheme.name = "Bibata-Modern-Classic";
    gtk.cursorTheme.package = pkgs.bibata-cursors;
    gtk.cursorTheme.size = 16;

    xdg.desktopEntries.discord = {
        name = "Discord";

        genericName = "Web Browser";

        icon = "discord";
        exec = "discord --enable-gpu-rasterization";

        terminal = false;

        type = "Application";

        categories = [ "Network" "WebBrowser" ];
    };
    xdg.userDirs.enable = true;

    programs.zsh = {
  	enable = true;
  	shellAliases = {
		sv = "sudo -E -s nvim";
		svim = "sudo -E -s nvim";
    		ll = "ls -l";
    		update = "sudo nixos-rebuild switch";
  	};

	plugins = [
	  {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
	  {
            name = "powerlevel10k-config";
            src = lib.cleanSource ./p10k-config;
            file = "p10k.zsh";
          }
          {
            name = "zsh-syntax-highlighting";
            src = pkgs.fetchFromGitHub {
              owner = "zsh-users";
              repo = "zsh-syntax-highlighting";
              rev = "0.7.1";
              sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
            };
          }
	];
    };
  };
}
