{ pkgs, ... }: 
let
  # We use the full path to binaries so the script never has to "guess"
  swww = "${pkgs.swww}/bin/swww";
  swwwDaemon = "${pkgs.swww}/bin/swww-daemon";
  
  wallScript = pkgs.writeShellScriptBin "wall-change" ''
    # Start daemon if not running
    if ! pgrep -x "swww-daemon" > /dev/null; then
      ${swwwDaemon} &
      sleep 0.5
    fi

    # Using /home/Theo instead of ~ is safer in Nix scripts
    # Make sure this path matches your actual folder!
    WALLDIR="/home/Theo/nix-conf/wallpapers"

    if [ -d "$WALLDIR" ]; then
      # Pick a random file
      WALLPAPER=$(${pkgs.findutils}/bin/find "$WALLDIR" -type f | ${pkgs.coreutils}/bin/shuf -n 1)
      ${swww} img "$WALLPAPER" --transition-type center
    else
      echo "Directory $WALLDIR not found"
    fi
  '';
in {
  home.packages = [ wallScript ];
}
