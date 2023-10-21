{ config, pkgs, ... }:

{
  home.username = "jordan";
  home.homeDirectory = "/home/jordan";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = [
    # cli
    pkgs.git
    pkgs.xclip
    
    # apps
    pkgs.jetbrains-toolbox
    pkgs.discord

  ];

  home.file = {
    ".vimrc".source = ./vim/.vimrc;
    ".ideavimrc".source = ./vim/.ideavimrc;
  };

  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
