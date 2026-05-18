{ config, pkgs, ... }:
let
  # Languages we want treesitter parsers for.
  treesitterLangs = [
    "bash"
    "c"
    "clojure"
    "cpp"
    "go"
    "java"
    "javascript"
    "json"
    "lua"
    "markdown"
    "markdown_inline"
    "nix"
    "python"
    "rust"
    "tsx"
    "typescript"
    "yaml"
  ];

  # Collect parser .so files into a single tree at $out/parser/<lang>.so.
  treesitterParsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = map (lang: pkgs.vimPlugins.nvim-treesitter-parsers.${lang}) treesitterLangs;
  };
in
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

    # Treesitter parsers and queries are NOT installed via plugins. lazy.nvim
    # resets the packpath at startup, which strips nix-installed plugins from
    # the runtime path. Instead we symlink them into ~/.config/nvim/{parser,
    # queries}, the canonical manual-install locations, which lazy does not
    # touch (see xdg.configFile below).
    plugins = with pkgs.vimPlugins; [ ];

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

    # Treesitter parser .so files (from nvim-treesitter-parsers.<lang>),
    # exposed at ~/.config/nvim/parser/<lang>.so.
    "nvim/parser".source = "${treesitterParsers}/parser";

    # Treesitter queries (highlights/injections/indents/etc.) from the upstream
    # nvim-treesitter plugin. The plugin's lua code is not initialized; only
    # its queries directory is exposed. The main-branch rewrite moved queries
    # under runtime/queries/.
    "nvim/queries".source = "${pkgs.vimPlugins.nvim-treesitter}/runtime/queries";
  };

  programs.zsh.shellAliases.vimdiff = "nvim -d";
}
