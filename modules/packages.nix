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
    python313Packages.numpy
    geteduroam

    typst
    gcc
    clang
    libgcc
    gnumake
    cmake
    openjdk
    zig
    rustc
    cargo
    php
    phpPackages.composer
  ];
}

