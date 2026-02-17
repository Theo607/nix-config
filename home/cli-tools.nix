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

    nodejs
    python3
  ];

  programs.starship.enable = true;

}

