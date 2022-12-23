{ config, pkgs, ... }:
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
    home.file.".config/picom".source = ../dotfiles/picom;
    home.file.".config/awesome".source = ../dotfiles/awesome;
    home.file.".config/rofi".source = ../dotfiles/rofi;

    gtk.enable = true;
    gtk.theme.name = "Dracula";
    gtk.theme.package = pkgs.dracula-theme;

    gtk.iconTheme.name = "WhiteSur";
    gtk.iconTheme.package = pkgs.whitesur-icon-theme;
  
    gtk.cursorTheme.name = "Bibata-Modern-Classic";
    gtk.cursorTheme.package = pkgs.bibata-cursors;
    gtk.cursorTheme.size = 16;
  };
}
