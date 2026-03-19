{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    
    # This is the correct way to get Wayland flags into VS Code on NixOS
    package = pkgs.vscode.fhs;

    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      rust-lang.rust-analyzer
      ms-python.python
      ms-vscode.cpptools
      golang.go
      esbenp.prettier-vscode
      eamodio.gitlens
    ];

    userSettings = {
      "window.titleBarStyle" = "custom";
      "editor.formatOnSave" = true;
      "terminal.integrated.env.linux" = {
        "NIXOS_OZONE_WL" = "1";
      };
    };
  };

  # This is the "Force Wayland" secret sauce for Niri
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Electron apps look for this
    # This forces VS Code (and other Electron apps) to use Wayland
    ELECTRON_OZONE_PLATFORM_HINT = "wayland"; 
  };
}
