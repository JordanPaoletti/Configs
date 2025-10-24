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
    poetry
    nodejs_24
  ];

  programs.zsh = {
    envExtra = ''
      export PATH="/Users/$USER/.local/bin:$PATH"
      export PATH="/Users/$USER/.toolbox/bin:$PATH"
    '';
    initContent = ''
      source ~/.brazil_completion/zsh_completion
      eval $(brew shellenv)
    '';

  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
