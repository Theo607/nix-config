{ config, pkgs, ... }:

{
  users.users.Theo = {
    isNormalUser = true;
    description = "Theo";
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  # Optional: enable sudo without password
  # security.sudo.enable = true;
  # security.sudo.wheelNeedsPassword = false;
}

