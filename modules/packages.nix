{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    neovim
    git
    zip
    unzip
    nix
    ghostty
    neofetch
    zoxide
    zellij
    obsidian
    home-manager
    firefox
    librewolf
    python313Packages.pip
    tmux
    openssh
    openconnect
    clang-tools
    subversion
    gnat
    ghc
    clisp
    smlnj
    ocaml
    swi-prolog
    alacritty
    waybar
    fuzzel
    wl-clipboard
    grim
    slurp

    typst
    go
    gcc
    clang
    libgcc
    gnumake
    cmake
    openjdk
    zig
    php
    phpPackages.composer
    rustup
    pinta

    google-chrome
  ];

  services.xserver.wacom.enable = true;
}

