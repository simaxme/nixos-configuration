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

    home.file.".config/awesome".source = ../desktop/awesome;
  };
}
