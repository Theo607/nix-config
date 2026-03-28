{ pkgs, ... }:

{
  home.packages = [ pkgs.kdePackages.okular pkgs.yazi ];
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    # In older HM versions, 'opener' and 'open' must live INSIDE 'settings'
    settings = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
      };

      # This maps to the [opener] section of yazi.toml
      opener = {
        pdf_reader = [
          {
            run = ''okular "$@"'';
            orphan = true;
            desc = "Okular";
          }
        ];
      };

      # This maps to the [open] section of yazi.toml
      open = {
        prepend_rules = [
          { mime = "application/pdf"; use = "pdf_reader"; }
          { name = "*.pdf"; use = "pdf_reader"; }
        ];
      };
    };

  };
}
