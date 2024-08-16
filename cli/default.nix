{ config, pkgs, ... }: {
  imports = [
  ../lib
  ./git.nix
  ./sh.nix
  ./nvim
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
    tmux

    # SDK / Frameworks
    texliveFull
  ];

  home.file = {
    ".vimrc".source = config.lib.file.mkFlakeSymlink ../dotfiles/.vimrc;
    ".ideavimrc".source = config.lib.file.mkFlakeSymlink ../dotfiles/.ideavimrc;
    ".tmux.conf".source = config.lib.file.mkFlakeSymlink ../dotfiles/.tmux.conf;
    ".keynavrc".source = config.lib.file.mkFlakeSymlink ../dotfiles/.keynavrc;
  };
}
