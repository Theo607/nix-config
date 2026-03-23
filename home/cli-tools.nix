{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    zoxide
    neofetch
    vim
    zip
    unzip
    ripgrep
    gh
    tree
    zathura
    starship
    bluetuith
    asciiquarium
    fastfetch
    less
    man
    cppman
    rusty-man
    tldr 
    nix-search
    nudoku
    sl
    ani-cli
    spotify-cli-linux
    spotify

    nodejs
    python3
    fzf
  ];

  programs.starship.enable = true;

}

