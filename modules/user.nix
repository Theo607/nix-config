{ config, pkgs, ... }:

{
  users.users.Theo = {
    isNormalUser = true;
    description = "Theo";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "$6$Bafn6KUDGpPfXR8A$isnFoa3CJ0Lf7a1h.VXmueX.z1aPRUJg1EhQ3aQBZ4IJIktJk1bBS9lEMF2FoqYmDFckjjWU5q3doHLq0rXlA0";
  };

  # Optional: enable sudo without password
  # security.sudo.enable = true;
  # security.sudo.wheelNeedsPassword = false;
}

