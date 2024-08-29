{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    syntaxHighlighting = {
      enable = true;
      catppuccin.enable = true;
    };

    initExtra = ''
      bindkey -M viins 'jk' vi-cmd-mode
      . ${pkgs.asdf-vm}/share/asdf-vm/asdf.sh

      if [ -f /home/$USER/.asdf/plugins/java/set-java-home.zsh ]; then
          . /home/$USER/.asdf/plugins/java/set-java-home.zsh
      fi
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
        "z"
      ];
    };

    shellAliases = {
      hms = "home-manager --flake . switch";
      "nixfmt." = "nixfmt $(find . -name '*.nix')";
      sudoe = "sudo --preserve-env=PATH env";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    catppuccin.enable = true;

    settings = {
      #      format = "$all$directory$character";
    };
  };
}
