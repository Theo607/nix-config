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
    tldr 
    nix-search
    nudoku
    spotify-cli-linux
    spotify

    nodejs
    python3
  ];

  programs.starship.enable = true;

}

