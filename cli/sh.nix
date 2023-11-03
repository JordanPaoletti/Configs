{
  programs.zsh = {
    enable = true;
    initExtra = ''
      bindkey -M viins 'jk' vi-cmd-mode
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "vi-mode" ];
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
