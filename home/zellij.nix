{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;

    settings = {
      # --- THEME ---
      theme = "gruvbox-dark"; # Options: "gruvbox-dark", "gruvbox-light"

      # --- UI CLEANUP ---
      show_startup_tips = false;
      show_sel_hints = false; 
      pane_frames = false;
      # simplified_ui = true;
      # default_layout = "compact";
      
      # --- GENERAL ---
      mouse_mode = true;
      copy_command = "wl-copy";
      default_shell = "bash";
    };
  };

  home.packages = with pkgs; [ 
    zellij 
    wl-clipboard 
    tmate
    ripdrag
  ];
}
