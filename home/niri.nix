{ pkgs, ... }: {
  # We use xdg.configFile instead of programs.niri to avoid 'option does not exist' errors
  xdg.configFile."niri/config.kdl".text = ''
input {
    keyboard {
        xkb {
            layout "pl"
        }
    }
    touchpad {
        tap
        dwt
    }
}

layout {
    gaps 12
    default-column-width { proportion 0.5; }
    background-color "transparent"


    border {
        width 1
        active-color "#d1d1d1"
        inactive-color "#333333"
    }
    
    focus-ring {
        width 1
        active-color "#d1d1d1"
        inactive-color "#333333"
    }
}

window-rule {
    geometry-corner-radius 12
    clip-to-geometry true
}

prefer-no-csd 
spawn-at-startup "swww-daemon"
spawn-at-startup "waybar"
spawn-at-startup "mako"
spawn-at-startup "wall-change"

binds {
    // Basic Essentials
    Mod+T { spawn "ghostty"; }
    Mod+D { spawn "rofi" "-show" "drun"; }
    Mod+Q { close-window; }
    Mod+Tab { toggle-overview; }
    Mod+Shift+E { quit; }
    Mod+W { spawn "wall-change"; }

    // --- RESIZING (Columns) ---
    // Make the focused column wider or narrower
    Mod+Minus { set-column-width "-10%"; }
    Mod+Equal { set-column-width "+10%"; }

    // Make the focused window taller or shorter (within a column)
    Mod+Shift+Minus { set-window-height "-10%"; }
    Mod+Shift+Equal { set-window-height "+10%"; }

    Mod+C { center-column; }

    // --- FOCUS (Moving your eyes) ---
    Mod+Left  { focus-column-left; }
    Mod+Right { focus-column-right; }
    Mod+Down  { focus-window-or-workspace-down; }
    Mod+Up    { focus-window-or-workspace-up; }
    
    // Quick jump to ends
    Mod+Home { focus-column-first; }
    Mod+End  { focus-column-last; }

    // --- MOVE (Rearranging windows) ---
    Mod+Shift+Left  { move-column-left; }
    Mod+Shift+Right { move-column-right; }
    
    // FIX: Simplified action names
    Mod+Shift+Down  { move-window-down; }
    Mod+Shift+Up    { move-window-up; }

    // --- WORKSPACES ---
    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }
    
    Mod+Shift+1 { move-column-to-workspace 1; }
    Mod+Shift+2 { move-column-to-workspace 2; }
    Mod+Shift+3 { move-column-to-workspace 3; }

    // This "reaches out" to the left and pulls the current window 
    // into the column on the left (at the bottom).
    Mod+Shift+J { consume-or-expel-window-left; }
    
    // Similarly for the right
    Mod+Shift+L { consume-or-expel-window-right; } 
}
    '';
}
