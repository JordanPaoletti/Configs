{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    initExtra = ''
      bindkey -M viins 'jk' vi-cmd-mode
      . ${pkgs.asdf-vm}/share/asdf-vm/asdf.sh

      if [ -f /home/$USER/.asdf/plugins/java/set-java-home.zsh ]; then
          . /home/$USER/.asdf/plugins/java/set-java-home.zsh
      fi
    '';

    sessionVariables = { PATH = "/home/$USER/.deno/bin:$PATH"; };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "vi-mode" "kubectl" "z" ];
    };

    shellAliases = {
      hms = "home-manager --flake . switch";
      "nixfmt." = "nixfmt-rfc-style $(find . -name '*.nix')";
      sudoe = "sudo --preserve-env=PATH env";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = { format = "$all$directory$character"; };
  };
}
