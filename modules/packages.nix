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
    home-manager
    firefox

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
  ];
}

