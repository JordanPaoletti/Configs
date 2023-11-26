{
  programs.zsh = {
    enable = true;
    initExtra = ''
      bindkey -M viins 'jk' vi-cmd-mode
    '';

    sessionVariables = { PATH = "/home/$USER/.deno/bin:$PATH"; };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "vi-mode" "asdf" "kubectl"];
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
    settings = { format = "$all$directory$character"; };
  };
}
