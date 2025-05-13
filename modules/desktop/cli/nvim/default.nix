{ config, pkgs, ... }:
{
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

    extraPackages = with pkgs; [
      tree-sitter
      gcc

      # language servers
      nixd
      nil
      bash-language-server
      lua-language-server
      yaml-language-server

      # formatters / linters
      nixfmt-rfc-style
      prettierd
      stylua
      shfmt
    ];
  };

  xdg.configFile = {
    "nvim/lua".source = config.lib.file.mkFlakeSymlink ./lua;
    "nvim/after".source = config.lib.file.mkFlakeSymlink ./after;
  };

  programs.zsh.shellAliases.vimdiff = "nvim -d";
}
