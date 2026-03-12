{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Kanagawa Dragon";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 13;
      
      # Essential for Wayland/Niri transparency
      window-decoration = false; 
      
      # Standard styling
      window-padding-x = 10;
      window-padding-y = 10;
      cursor-style = "block";
    };
  };
}
