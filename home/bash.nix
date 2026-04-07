{ pkgs, ... }:

{
  programs.bash = {
    enable = true;

    initExtra = ''
      # Tools
      command -v fastfetch >/dev/null 2>&1 && alias ff='fastfetch'
      command -v nvim >/dev/null 2>&1 && alias nv='nvim'
      if command -v zoxide >/dev/null 2>&1; then
          eval "$(zoxide init bash)"
      fi
      command -v htop >/dev/null 2>&1 && alias top='htop'

      # Listing
      alias ll='ls -lh --color=auto'

      # Git
      alias gs='git status'
      alias ga='git add'
      alias gcb='git checkout -b'
      alias gcm='git commit -m'
      alias gp='git push'
      alias gpl='git pull'
      alias gco='git checkout'
      alias gcl='git clone'

      # Navigation
      alias ..='cd ..'
      alias ...='cd ../..'
      alias ....='cd ../../..'
      alias .....='cd ../../../..'
      
      # Playerctl
      alias pp='playerctl play-pause'
      alias pn='playerctl next'
      alias pv='playerctl previous'
      
      # History improvements
      shopt -s histappend   
      HISTSIZE=5000
      HISTFILESIZE=10000
      HISTCONTROL=ignoredups:erasedups

      # Smart shell behavior
      shopt -s checkwinsize  
      shopt -s autocd       
      shopt -s cdspell     
      shopt -s histverify

      update_history() {
        history -a   
        history -n  
      }

      PROMPT_COMMAND="update_history;$PROMPT_COMMAND"

      # System info
      alias mem='free -h'
      alias dfh='df -h'

      # Handy
      alias c='clear'

      extract() {
        if [ -f "$1" ]; then
        case "$1" in
          *.tar.bz2)   tar xjf "$1" ;;
          *.tar.gz)    tar xzf "$1" ;;
          *.bz2)       bunzip2 "$1" ;;
          *.rar)       unrar x "$1" ;;
          *.gz)        gunzip "$1" ;;
          *.tar)       tar xf "$1" ;;
          *.zip)       unzip "$1" ;;
          *.7z)        7z x "$1" ;;
          *)           echo "'$1' cannot be extracted via extract()" ;;
          esac
        else
          echo "'$1' is not a valid file"
            fi
      }
    '';
  };

  home.packages = with pkgs; [
    zoxide
    gzip
    bzip2 
    zip
    unzip
    p7zip
    unrar
    xz
    lzop
  ];
}

