{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      modules-left = [ "niri/workspaces" ];
      modules-center = [ "niri/window" ];
      modules-right = [ "battery" "clock" ];

      battery = {
        format = "{icon} {capacity}%";
        format-icons = [ "" "" "" "" "" ]; # Font Awesome / Nerd Font symbols
      };
    }];
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", Roboto, Helvetica, Arial, sans-serif;
        font-size: 13px;
      }
      window#waybar {
        background: rgba(43, 48, 59, 0.5);
        color: #ffffff;
      }
    '';
  };
}
