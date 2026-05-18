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
      # Treesitter parser .so files. Neovim 0.12 handles highlighting/indent
      # natively; we only need the parsers on the runtime path.
      #
      # nvim-treesitter itself is included for its `queries/` directory only
      # (e.g. markdown → markdown_inline injection). The plugin code is not
      # initialized.
      nvim-treesitter
      nvim-treesitter-parsers.bash
      nvim-treesitter-parsers.c
      nvim-treesitter-parsers.clojure
      nvim-treesitter-parsers.cpp
      nvim-treesitter-parsers.go
      nvim-treesitter-parsers.java
      nvim-treesitter-parsers.javascript
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.markdown
      nvim-treesitter-parsers.markdown_inline
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.rust
      nvim-treesitter-parsers.tsx
      nvim-treesitter-parsers.typescript
      nvim-treesitter-parsers.yaml
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
