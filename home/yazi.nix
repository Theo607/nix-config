{ pkgs, ... }:

{
  home.packages = [ 
    pkgs.kdePackages.okular 
    pkgs.yazi 
    pkgs.loupe 
    pkgs.mpv
    pkgs.zathura
    pkgs.libreoffice-fresh # Includes Writer, Calc, Impress, etc.
    pkgs._7zz               # Modern 7-zip for archives
    pkgs.sqlite             # For database viewing if needed
  ];

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    keymap = {
      # --- UPDATED: 'manager' changed to 'mgr' ---
      mgr.prepend_keymap = [
        {
          on = [ "<C-d>" ];
          run = ''shell 'ripdrag "$@"' --confirm'';
          desc = "Drag and drop selected files via ripdrag";
        }
      ];
    };

    settings = {
      # --- UPDATED: 'manager' changed to 'mgr' ---
      mgr = { 
        sort_by = "natural"; 
      };

      opener = {
        # Text & Code (Terminal Blocking)
        editor = [
          { run = ''nvim "$@"''; block = true; desc = "Neovim"; }
        ];
        # Office Documents (GUI Orphan)
        office = [
          { run = ''libreoffice "$@"''; orphan = true; desc = "LibreOffice"; }
        ];
        # Media (GUI Orphan)
        media_player = [
          { run = ''mpv "$@"''; orphan = true; desc = "mpv"; }
        ];
        # Image Viewer
        image_viewer = [
          { run = ''loupe "$@"''; orphan = true; desc = "Loupe"; }
        ];
        # Archives
        archiver = [
          { run = ''7zz x "$@"''; block = true; desc = "Extract here (7zip)"; }
        ];
        # PDF
        pdf_reader = [
          { run = ''okular "$@"''; orphan = true; desc = "Okular"; }
        ];
      };

      open = {
        prepend_rules = [
          # --- CODE & CONFIGS ---
          { name = "*.{sh,bash,zsh,fish,lua,nix,conf,ini,toml,yaml,yml,json}"; use = "editor"; }
          { name = "*.{c,cpp,h,hpp,rs,go,py,js,ts,jsx,tsx,html,css,scss,md,sql}"; use = "editor"; }
          { mime = "text/*"; use = "editor"; }

          # --- OFFICE DOCUMENTS ---
          { mime = "application/vnd.openxmlformats-officedocument.*"; use = "office"; }
          { mime = "application/vnd.ms-*"; use = "office"; }
          { mime = "application/vnd.oasis.opendocument.*"; use = "office"; }
          { name = "*.{doc,docx,xls,xlsx,ppt,pptx,odt,ods,odp,rtf}"; use = "office"; }

          # --- ARCHIVES ---
          { mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd}"; use = "archiver"; }
          { name = "*.{zip,7z,tar,gz,tgz,xz,rar,zipx}"; use = "archiver"; }

          # --- MEDIA & IMAGES ---
          { mime = "{video,audio}/*"; use = "media_player"; }
          { mime = "image/*"; use = "image_viewer"; }
          { name = "*.svg"; use = "image_viewer"; }

          # --- DOCUMENTS ---
          { mime = "application/pdf"; use = "pdf_reader"; }

          # --- WEIRD / MISC ---
          { name = "*.{db,sqlite,sqlite3}"; use = "editor"; } 
          { name = "*.log"; use = "editor"; }
        ];
      };
    };
  };
}
