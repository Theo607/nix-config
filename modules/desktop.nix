{ config, pkgs, ... }:

{
  # X11 / GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Keyboard layout
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    gnomeExtensions.forge
  ];
}

