{ pkgs, ... }: 
let
  swww = "${pkgs.swww}/bin/swww";
in {
  home.packages = [ 
    (pkgs.writeShellScriptBin "wall-next" ''
      WALLDIR="$HOME/nix-conf/wallpapers"
      LAST_WALL_FILE="/tmp/last_wallpaper"
      
      # 1. Ensure daemon is running
      if ! pgrep -x "swww-daemon" > /dev/null; then
        ${swww}-daemon &
        sleep 0.5
      fi

      # 2. Get a sorted list of all wallpapers
      # 'sort' ensures the order is always the same (alphabetical)
      WALLS=($(${pkgs.findutils}/bin/find -L "$WALLDIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) | sort))
      
      NUM_WALLS=''${#WALLS[@]}
      if [ "$NUM_WALLS" -eq 0 ]; then
        echo "No wallpapers found."
        exit 1
      fi

      # 3. Get the current wallpaper path
      CURRENT_WALL=$(cat "$LAST_WALL_FILE" 2>/dev/null || echo "")

      # 4. Find the index of the current wall in the sorted array
      NEXT_INDEX=0
      for i in "''${!WALLS[@]}"; do
         if [[ "''${WALLS[$i]}" == "$CURRENT_WALL" ]]; then
            # We found the current one, so the next one is i + 1
            NEXT_INDEX=$(( (i + 1) % NUM_WALLS ))
            break
         fi
      done

      NEW_WALL="''${WALLS[$NEXT_INDEX]}"

      # 5. Apply and Save
      ${swww} img "$NEW_WALL" --transition-type none
      echo "$NEW_WALL" > "$LAST_WALL_FILE"
    '') 
  ];
}
