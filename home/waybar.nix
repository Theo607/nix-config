{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      modules-left = [ "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "pulseaudio#microphone" "cpu" "memory" "battery" "network" "tray" ];

      "niri/workspaces" = {
        format = "{index}";
      };

      # --- Audio Modules (Now correctly inside settings) ---
      "pulseaudio" = {
        format = "{icon}  {volume}%";
        format-muted = "󰝟 ";
        format-icons = {
          default = ["󰕿" "󰖀" "󰕾"];
        };
        on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      "pulseaudio#microphone" = {
        format = "{format_source}";
        format-source = " {volume}%";
        format-source-muted = " ";
        on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        on-scroll-up = "${pkgs.pamixer}/bin/pamixer --default-source -i 5";
        on-scroll-down = "${pkgs.pamixer}/bin/pamixer --default-source -d 5";
      };

      # --- Rest of your modules ---
      network = {
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

      #workspaces, #window, #clock, #cpu, #memory, #battery, #network, #tray, #pulseaudio {
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

      #network { color: #a9b1d6; }
      #battery { color: #9ece6a; }
      #pulseaudio { color: #f7768e; }
      #pulseaudio.microphone { color: #ff9e64; padding: 0 10px; }
    '';
  };
}
