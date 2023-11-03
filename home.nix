{ config, pkgs, ... }: {
  imports = [ ./cli ];
  home.username = "jordan";
  home.homeDirectory = "/home/jordan";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    # cli
    xclip

    # apps
    jetbrains-toolbox
    discord

    # nix
    nixfmt
  ];

  home.file = {
    ".vimrc".source = ./dotfiles/.vimrc;
    ".ideavimrc".source = ./dotfiles/.ideavimrc;
    ".tmux.conf".source = ./dotfiles/.tmux.conf;
    ".keynavrc".source = ./dotfiles/.keynavrc;
  };

  home.sessionVariables = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
