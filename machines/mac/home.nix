{ config, pkgs, ... }:

{
  imports = [
    ../../modules/desktop/cli
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "paoletjo";
    homeDirectory = "/Users/paoletjo";
    flakePath = "/Users/paoletjo/.config/home-manager";
  };

  home.packages = with pkgs; [
    nixfmt-rfc-style
  ];

  programs.zsh.initContent = ''
    eval "$(luarocks path --bin)"
  '';

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
