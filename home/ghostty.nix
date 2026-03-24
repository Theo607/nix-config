{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Gruvbox Dark";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 13;
      
      window-decoration = false; 
      
      window-padding-x = 10;
      window-padding-y = 10;
      cursor-style = "block";
    };
  };
}
