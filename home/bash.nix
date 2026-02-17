{ pkgs, ... }:

{
  programs.bash = {
    enable = true;

    # Add custom lines to .bashrc
    initExtra = ''
      # zoxide setup
      if command -v zoxide >/dev/null 2>&1; then
          eval "$(zoxide init bash)"
      fi

      # Example aliases
      alias ll='ls -lh --color=auto'
      alias gs='git status'

      # Example function
      mkcd() {
          mkdir -p "$1" && cd "$1"
      }
    '';
  };

  # Install zoxide for the user
  home.packages = with pkgs; [
    zoxide
  ];
}

