{ config, pkgs, ... }:

{
  home-manager.users.Theo = { pkgs, ... }: {
    imports = [
      ../home/neovim.nix
      ../home/cli-tools.nix
      ../home/bash.nix
      ../home/general.nix
    ];

    home.stateVersion = "25.11";
  };
}

