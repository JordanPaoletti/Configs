{ pkgs, ... }: {
  imports = [ ./git.nix ./sh.nix ];

  home.packages = with pkgs; [
    # cli apps
    xclip
    deno
    asdf-vm
    kubectl
    tree
  ];

  home.file = {
    ".vimrc".source = ../dotfiles/.vimrc;
    ".ideavimrc".source = ../dotfiles/.ideavimrc;
    ".tmux.conf".source = ../dotfiles/.tmux.conf;
    ".keynavrc".source = ../dotfiles/.keynavrc;
  };
}
