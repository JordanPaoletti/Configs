{ config, pkgs, ... }:
{
  imports = [
    ../lib
    ./git.nix
    ./zsh.nix
    ./nvim
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    # cli apps
    xclip
    deno
    asdf-vm
    kubectl
    kubernetes-helm
    tree
    certbot
    qmk

    # SDK / Frameworks
    # texliveFull
  ];

  home.file = {
    ".vimrc".source = config.lib.file.mkFlakeSymlink ../dotfiles/.vimrc;
    ".ideavimrc".source = config.lib.file.mkFlakeSymlink ../dotfiles/.ideavimrc;
    ".keynavrc".source = config.lib.file.mkFlakeSymlink ../dotfiles/.keynavrc;
  };
}
