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
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };


  networking.hostName = "nixos";

  system.stateVersion = "25.11";


}

