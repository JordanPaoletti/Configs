{ pkgs, ... }: {
  imports = [ ./git.nix ./sh.nix ./nvim ];

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
    ".vimrc".source = ../dotfiles/.vimrc;
    ".ideavimrc".source = ../dotfiles/.ideavimrc;
    ".tmux.conf".source = ../dotfiles/.tmux.conf;
    ".keynavrc".source = ../dotfiles/.keynavrc;
  };
}
