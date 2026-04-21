{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    syntaxHighlighting = {
      enable = true;
    };

    initContent = ''
      bindkey -M viins 'jk' vi-cmd-mode

      if command -v luarocks &> /dev/null; then
        eval "$(luarocks path --bin)"
      fi

      # sesh tmux fzf integration
      function sesh-sessions() {
        {
          exec </dev/tty
          exec <&1
          local session
          session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
          zle reset-prompt > /dev/null 2>&1 || true
          [[ -z "$session" ]] && return
          sesh connect $session
        }
      }

      zle     -N             sesh-sessions
      bindkey -M emacs '\es' sesh-sessions
      bindkey -M vicmd '\es' sesh-sessions
      bindkey -M viins '\es' sesh-sessions

      # easily invoke a shell with a package from nixpkgs
      function nshell () { nix shell nixpkgs#$1 }
    '';

    envExtra = ''
      export PATH="/home/$USER/.deno/bin:$PATH"
      export PATH="/home/$USER/.local/bin:$PATH"
    '';

    sessionVariables = {
      PATH = "/home/$USER/.deno/bin:$PATH";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "vi-mode"
        "kubectl"
      ];
    };

    history.share = false;

    shellAliases = {
      hms = "home-manager --flake . switch";
      "nixfmt." = "nixfmt $(find . -name '*.nix')";
      sudoe = "sudo --preserve-env=PATH env";
      nixd = "nix develop -c $SHELL";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--ansi"
      # https://github.com/catppuccin/fzf
      "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8"
      "--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc"
      "--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
    ];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      #      format = "$all$directory$character";
    };
  };

  catppuccin = {
    starship.enable = true;
    zsh-syntax-highlighting.enable = true;
  };
}
