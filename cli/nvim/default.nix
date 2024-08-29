{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = builtins.readFile ./init.vim;
    extraLuaConfig = ''
      require('user')
    '';

    plugins = with pkgs.vimPlugins; [ lazy-nvim ];
  };

  xdg.configFile = {
    "nvim/lua".source = config.lib.file.mkFlakeSymlink ./lua;
  };

  programs.zsh.shellAliases.vimdiff = "nvim -d";
}
