{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 34;
      spacing = 4;
      modules-left = [ "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "network" "cpu" "memory" "battery" "tray" ];

      "niri/workspaces" = {
        format = "{index}";
      };

      network = {
        # Click to open a GUI to manage connections
        on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        format-wifi = " {essid}";
        format-ethernet = "󰈀 {ifname}";
        format-disconnected = "󰖪 Disconnected";
        tooltip-format = "{ifname} via {gwaddr} 󰊗";
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = "󱐋 {capacity}%";
        format-icons = [ "" "" "" "" "" ];
      };

      clock = {
        format = "󰃭 {:%H:%M}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      cpu = { format = " {usage}%"; };
      memory = { format = " {}%"; };
      
      tray = {
        spacing = 10;
      };
    }];

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: rgba(26, 27, 38, 0.85); /* Tokyo Night style */
        color: #c0caf5;
        border-bottom: 2px solid rgba(122, 162, 247, 0.5);
      }

      #workspaces button {
        padding: 0 5px;
        color: #7aa2f7;
      }

      #workspaces button.focused {
        color: #bb9af7;
        background-color: rgba(187, 154, 247, 0.2);
      }

      #network, #cpu, #memory, #battery, #clock {
        padding: 0 10px;
        margin: 4px 2px;
        background-color: rgba(47, 51, 73, 0.8);
        border-radius: 6px;
      }

      #network { color: #7aa2f7; }
      #battery { color: #9ece6a; }
      #battery.warning { color: #e0af68; }
      #battery.critical { color: #f7768e; }
    '';
  };
}
