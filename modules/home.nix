{ config, pkgs, niri, ... }:

{
  home-manager.users.Theo = { pkgs, ... }: {
    imports = [
      ../home/neovim.nix
      ../home/helix.nix
      ../home/vscode.nix
      ../home/cli-tools.nix
      ../home/bash.nix
      ../home/general.nix
      ../home/niri.nix
      ../home/waybar.nix
      ../home/wallpaper.nix
      ../home/ghostty.nix
      ../home/rofi.nix
      ../home/krita.nix
      ../home/yazi.nix
      ../home/zellij.nix
      ../home/steam.nix
    ];
    services.network-manager-applet.enable = false;

    home.stateVersion = "25.11";
  };
}

