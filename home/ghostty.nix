{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    # This automatically handles the config file
    settings = {
      theme = "TokyoNight";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 13;
      window-decoration = false; # This might solve your icon/header issue!
      window-padding-x = 10;
      window-padding-y = 10;
      cursor-style = "block";
    };
  };
}
