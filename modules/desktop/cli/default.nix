{ config, pkgs, ... }:
{
  imports = [
    ../../lib
    ./git.nix
    ./zsh.nix
    ./nvim
    ./tmux.nix
  ];

  # catppuccin/nix now requires autoEnable to be set explicitly to theme
  # installed programs automatically.
  catppuccin = {
    enable = true;
    autoEnable = true;
  };

  home.packages = with pkgs; [
    # cli apps
    xclip
    kubectl
    kubernetes-helm
    tree
    qmk
    just
    unzip
    httpie
    nixfmt
    sesh

    # More dev related
    bun
    nodejs
    luajit
    luajitPackages.luarocks
    jdk
    leiningen
    python3
  ];

  home.file = {
    ".vimrc".source = config.lib.file.mkFlakeSymlink ../../../dotfiles/.vimrc;
    ".ideavimrc".source = config.lib.file.mkFlakeSymlink ../../../dotfiles/.ideavimrc;
    ".keynavrc".source = config.lib.file.mkFlakeSymlink ../../../dotfiles/.keynavrc;
  };
}
