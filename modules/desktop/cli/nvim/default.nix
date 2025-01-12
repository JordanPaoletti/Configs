{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tree-sitter
    gcc
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = builtins.readFile ./init.vim;
    extraLuaConfig = ''
      require('user')
    '';

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      nvim-treesitter
    ];
  };

  xdg.configFile = {
    "nvim/lua".source = config.lib.file.mkFlakeSymlink ./lua;
    "nvim/after".source = config.lib.file.mkFlakeSymlink ./after;
  };

  programs.zsh.shellAliases.vimdiff = "nvim -d";
}
