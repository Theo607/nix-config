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
    starship

    nodejs
    python3
  ];

  programs.starship.enable = true;

}

