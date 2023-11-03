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
      pbcopy = "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -o";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = { format = "$all$directory$character"; };
  };
}
