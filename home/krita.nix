{ config, pkgs, ... }:

{
  home.packages = [
    # Wrap Krita to force Wayland and ignore X11 entirely
    pkgs.krita
    pkgs.krita-plugin-gmic
    pkgs.libwacom
    pkgs.evtest
  ];

  # Keep these for other apps, but the wrapper above protects Krita
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_AUTOSCREEN_SCALE_FACTOR = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
