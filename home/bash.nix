{ pkgs, ... }:

{
  programs.bash = {
    enable = true;

    initExtra = ''
      # zoxide setup
      if command -v zoxide >/dev/null 2>&1; then
          eval "$(zoxide init bash)"
      fi

      # Example aliases
      alias ll='ls -lh --color=auto'
      alias gs='git status'
      alias ga='git add'
      alias ff='fastfetch'
      alias nv='nvim'
      alias gc='git commit'
      alias ..='cd ..'
    '';
  };

  home.packages = with pkgs; [
    zoxide
  ];
}

