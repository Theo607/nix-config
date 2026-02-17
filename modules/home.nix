{ config, pkgs, ... }:

{
  home-manager.users.Theo = { pkgs, ... }: {
    imports = [
      ../home/neovim.nix
      ../home/cli-tools.nix
      ../home/bash.nix
      ../home/general.nix
    ];

    programs.gnome.enable = true;

    programs.gnome.extensions = [
      "forge@jmmaranan.com"
    ];

    home.stateVersion = "25.11";
  };
}

