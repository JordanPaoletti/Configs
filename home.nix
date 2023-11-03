{ config, pkgs, ... }: {
  imports = [ ./cli ./apps ];
  home.username = "jordan";
  home.homeDirectory = "/home/jordan";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  # Nix related packages
  home.packages = with pkgs; [ nixfmt ];

  home.sessionVariables = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
