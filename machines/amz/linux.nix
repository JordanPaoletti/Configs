{ ... }:

{
  imports = [
    ../../modules/desktop/cli
    ./common.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "paoletjo";
    homeDirectory = "/home/paoletjo";
    flakePath = "/home/paoletjo/.config/home-manager";
  };

  programs.zsh = {
    envExtra = ''
      export PATH="/home/$USER/.local/bin:$PATH"
      export PATH="/home/$USER/.toolbox/bin:$PATH"
      export PATH="/home/$USER/dev/scripts/shell:$PATH"
    '';

    initContent = ''
      source ~/.brazil_completion/zsh_completion
      source ~/.nix-profile/etc/profile.d/nix.sh

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
