{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      modules-left = [ "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "cpu" "memory" "battery" "network" "tray" ];

      "niri/workspaces" = {
        format = "{index}";
      };

      network = {
        # Using much cleaner "Signal" icons
        format-wifi = "󰤨  {essid}";
        format-ethernet = "󰈀 ";
        format-disconnected = "󰖪 ";
      };

      battery = {
          format = "{icon}  {capacity}%";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
      };
      clock = { format = "󱑂  {:%H:%M}"; };
      cpu = { format = "  {usage}%"; };
      memory = { format = "  {percentage}%"; };
      
      tray = { 
        spacing = 8;
        icon-size = 15;
      };
    }];

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", "Symbols Nerd Font";
        font-weight: bold;
      }

      window#waybar {
        background: rgba(10, 10, 10, 0.9);
        color: #d1d1d1;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      }

      /* No more squares or backgrounds! */
      #workspaces, #window, #clock, #cpu, #memory, #battery, #network, #tray {
        padding: 0 10px;
        background: transparent;
      }

      #workspaces button {
        color: #555555;
      }

      #workspaces button.focused {
        color: #d1d1d1;
        border-bottom: 2px solid #d1d1d1;
      }

      /* Clean separation using a simple dot or space */
      #network { color: #a9b1d6; }
      #battery { color: #9ece6a; }
    '';
  };
}
