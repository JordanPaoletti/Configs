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
  ];

  programs.zsh = {
    envExtra = ''
      export PATH="/Users/$USER/.local/bin:$PATH"
      export PATH="/Users/$USER/.toolbox/bin:$PATH"
      export PATH="/Users/$USER/dev/scripts/shell:$PATH"
    '';
    initContent = ''
      source ~/.brazil_completion/zsh_completion
      eval $(brew shellenv)

      # setup nvm
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    '';

  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
