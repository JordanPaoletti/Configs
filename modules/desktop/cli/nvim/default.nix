{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;
    extraConfig = builtins.readFile ./init.vim;
    initLua = ''
      require('user')
    '';

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraPackages = with pkgs; [
      tree-sitter
      gcc
      ripgrep

      # language servers
      nixd
      nil
      bash-language-server
      lua-language-server
      yaml-language-server
      python313Packages.jedi-language-server
      clojure-lsp
      jdt-language-server

      # formatters / linters
      nixfmt
      prettierd
      stylua
      shfmt
      black

      # Debuggers
      python313Packages.debugpy
    ];
  };

  xdg.configFile = {
    "nvim/lua".source = config.lib.file.mkFlakeSymlink ./lua;
    "nvim/after".source = config.lib.file.mkFlakeSymlink ./after;
  };

  programs.zsh.shellAliases.vimdiff = "nvim -d";
}
