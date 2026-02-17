{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system.nix
    ../../modules/desktop.nix
    ../../modules/user.nix
    ../../modules/packages.nix
    ../../modules/fonts.nix
    ../../modules/home.nix
  ];

  networking.hostName = "nixos";

  system.stateVersion = "25.11";
}

