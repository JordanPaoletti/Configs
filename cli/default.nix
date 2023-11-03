{ pkgs, ... }: {
  imports = [ ./git.nix ./zsh.nix ];

  home.packages = with pkgs; [ xclip ];

  home.file = {
    ".vimrc".source = ../dotfiles/.vimrc;
    ".ideavimrc".source = ../dotfiles/.ideavimrc;
    ".tmux.conf".source = ../dotfiles/.tmux.conf;
    ".keynavrc".source = ../dotfiles/.keynavrc;
  };
}
