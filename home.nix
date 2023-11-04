{ config, pkgs, ... }: {
  imports = [ ./cli ./apps ];

  home = {
    username = "jordan";
    homeDirectory = "/home/jordan";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  # Nix related packages
  home.packages = with pkgs; [ nixfmt ];

  home.sessionVariables = { };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
