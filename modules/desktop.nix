{ pkgs, ... }: {
  # Enable Niri session (System level)
  programs.niri.enable = true;

  # Graphics & Portals
  hardware.graphics = {
    enable = true;
    extraPackages = [ pkgs.mesa ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = [ "gnome" "gtk" ];
  };

  # Login Manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "Theo"; 
      };
    };
  };

  # Move specific apps (alacritty, fuzzel, etc.) to home/ or packages.nix
  environment.systemPackages = [ 
      pkgs.tuigreet 
      pkgs.networkmanagerapplet
      pkgs.swww
  ];
}
