{ pkgs, ... }:

{
  home.packages = with pkgs; [
    musikcube
    playerctl
    fum
    git
    vlc
    zoxide
    neofetch
    vim
    zip
    feh
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
    R
  ];

  programs.starship.enable = true;

}

