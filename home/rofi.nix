{ pkgs, config, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      # 1. Define variables
      "*" = {
        bg = mkLiteral "#0a0a0a";       # Dark background
        fg = mkLiteral "#d1d1d1";       # Light grey text
        accent = mkLiteral "#333333";   # Selection color
        
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
      };

      # 2. Force the window background
      "window" = {
        background-color = mkLiteral "@bg";
        border = mkLiteral "1px";
        border-color = mkLiteral "#d1d1d133";
        border-radius = mkLiteral "12px";
        width = mkLiteral "600px";
        padding = mkLiteral "20px";
      };

      # 3. Ensure the main container is dark
      "mainbox" = {
        background-color = mkLiteral "transparent";
      };

      "inputbar" = {
        children = mkLiteral "[prompt,entry]";
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px 0px 10px 0px";
      };

      "entry" = {
        placeholder = "Search apps...";
        placeholder-color = mkLiteral "#666666";
      };

      "listview" = {
        lines = 8;
        fixed-height = true;
      };

      # 4. Fix the selection colors
      "element" = {
        padding = mkLiteral "8px";
        border-radius = mkLiteral "6px";
      };

      "element selected" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@fg";
      };
      
      "element-icon" = {
        size = mkLiteral "24px";
        margin = mkLiteral "0px 10px 0px 0px";
      };
    };
  };
}
