{ pkgs, ... }: 
let
  swww = "${pkgs.swww}/bin/swww";
in {
  home.packages = [ (pkgs.writeShellScriptBin "wall-change" ''
    WALLDIR="/home/$(whoami)/nix-conf/wallpapers"
    LAST_WALL_FILE="/tmp/last_wallpaper"
    
    # 1. Ensure the daemon is running
    if ! pgrep -x "swww-daemon" > /dev/null; then
      ${pkgs.swww}/bin/swww-daemon &
      sleep 0.2
    fi

    # 2. Pick a wallpaper that isn't the current one
    CURRENT_WALL=$(cat $LAST_WALL_FILE 2>/dev/null || echo "")
    
    NEW_WALL=$(${pkgs.findutils}/bin/find "$WALLDIR" -type f ! -path "$CURRENT_WALL" | ${pkgs.coreutils}/bin/shuf -n 1)

    # 3. Set it instantly
    # --transition-type none makes it instant. 
    # Or use --transition-step 255 for a super fast "pop"
    ${swww} img "$NEW_WALL" --transition-type none

    # 4. Save this choice for next time
    echo "$NEW_WALL" > "$LAST_WALL_FILE"
  '') ];
}
