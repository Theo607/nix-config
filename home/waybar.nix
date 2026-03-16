{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      modules-left = [ "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "backlight" "pulseaudio" "pulseaudio#microphone" "cpu" "memory" "battery" "network" "tray" ];

      "niri/workspaces" = {
        format = "{index}";
      };

      # --- Brightness Module ---
      "backlight" = {
        device = "intel_backlight"; # Change to "amd_backlight" if you have an AMD CPU
        format = "{icon} {percent}%";
        format-icons = [ "󰃞" "󰃟" "󰃠" ];
        on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
        on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
      };

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

      /* ADDED #backlight here */
      #workspaces, #window, #clock, #cpu, #memory, #battery, #network, #tray, #pulseaudio, #backlight {
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
      #backlight { color: #e0af68; } /* TokyoNight yellow-ish color */
      #pulseaudio.microphone { color: #ff9e64; padding: 0 10px; }
    '';
  };
}
