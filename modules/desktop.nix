{ pkgs, ... }: {
  # Enable Niri session (System level)
  programs.niri.enable = true;

  # Graphics & Portals
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ 
      mesa 
      libva               # Video acceleration
      libva-vdpau-driver
      libvdpau-va-gl      # Video acceleration    
      rocmPackages.clr.icd
      ];
  };

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gnome 
      pkgs.xdg-desktop-portal-gtk 
    ];
    config = {
      common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
      # Niri specific overrides if needed
      niri = {
        default = [ "gnome" "gtk" ];
      };
    };
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct"; # Or "gnome" if using portal-gnome
      GDK_BACKEND = "wayland";
  };

  services.xserver = {
	  enable = true;
	  displayManager.gdm.enable = true;
  };

  # In configuration.nix
  programs.xwayland.enable = true;


  services.xserver.displayManager.gdm = {
    wayland = true;
  };

  services.xserver.desktopManager.gnome.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.seahorse.enable = false;
  
  # Login Manager
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
  #       user = "Theo"; 
  #     };
  #   };
  # };

  # Move specific apps (alacritty, fuzzel, etc.) to home/ or packages.nix
  environment.systemPackages = [ 
      pkgs.tuigreet 
      pkgs.networkmanagerapplet
      pkgs.swww
      pkgs.rofi
      pkgs.qt5.qtwayland
      pkgs.qt6.qtwayland
      pkgs.kdePackages.kwayland # Important for Krita (KDE-based)
      pkgs.libva # For hardware acceleration
  ];
}
