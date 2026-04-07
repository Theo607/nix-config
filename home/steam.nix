{ pkgs, ... }:

{
  home.packages = with pkgs; [
    steam
    steam-run      
    protontricks  
    gamemode     
  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
  };
}
