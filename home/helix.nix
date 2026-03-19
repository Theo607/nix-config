{ pkgs, ... }:

{
  programs.helix = {
    enable = true;

    # General settings (like init.lua opts)
    settings = {
      theme = "gruvbox";

      editor = {
        line-number = "relative";
        cursorline = true;
        scrolloff = 8;
      };
    };

    # Language-specific configuration
    languages = {
      rust = {
        lsp = {
          enable = true;
          settings = {
            rust_analyzer = {
              cargo = { allFeatures = true; };
              checkOnSave = { command = "clippy"; };
              rustc = { source = "discover"; };
            };
          };
        };
        format = { auto = true; };
      };

      python = { lsp = { enable = true; server = pkgs.pyright; }; format = { auto = true; }; };
      typescript = { lsp = { enable = true; server = pkgs.typescript-language-server; }; };
      go = { lsp = { enable = true; server = pkgs.gopls; }; };
      c = { lsp = { enable = true; server = pkgs.clang-tools; }; };
      cpp = { lsp = { enable = true; server = pkgs.clang-tools; }; };
      nix = { lsp = { enable = true; server = pkgs.nixd; }; };
      html = { lsp = { enable = true; server = pkgs.vscode-langservers-extracted; }; };
      css = { lsp = { enable = true; server = pkgs.vscode-langservers-extracted; }; };
      php = { lsp = { enable = true; server = pkgs.phpactor; }; };
    };

    # Optional: use nix-managed binaries for all LSPs
    extraPackages = with pkgs; [
      pyright
      gopls
      clang-tools
      nixd
      zls
      vscode-langservers-extracted
      typescript-language-server
      phpactor
      kotlin-language-server
      jdt-language-server
      haskell-language-server
      ocamlPackages.ocaml-lsp
    ];
  };
}
