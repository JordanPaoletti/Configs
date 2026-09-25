{ config, pkgs, ... }:

{
  imports = [
    ../../modules/desktop/cli
    ./common.nix
    ../../modules/lib
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "paoletjo";
    homeDirectory = "/Users/paoletjo";
    flakePath = "/Users/paoletjo/.config/home-manager";
  };

  home.packages = with pkgs; [
    mutagen
    autossh
  ];

  programs.zsh = {
    envExtra = ''
      export PATH="/Users/$USER/.local/bin:$PATH"
      export PATH="/Users/$USER/.toolbox/bin:$PATH"
      export PATH="/Users/$USER/dev/scripts/shell:$PATH"
      export DOCKER_HOST=unix:///Applications/Finch/lima/data/finch/sock/finch.sock
    '';

    initContent = ''
      source ~/.brazil_completion/zsh_completion
      eval $(brew shellenv)

      # hopefully stop mac updates from breaking nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      # setup nvm
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

      # When a connection drops, the remote app never turns off the terminal
      # modes it set, so turn them off here. Exit code 255 means ssh itself failed.
      function ssh() {
        command ssh "$@"
        local rc=$?
        if [[ -t 1 ]]; then
          # mouse reporting, focus events, bracketed paste, synchronized output
          printf '\e[?1000l\e[?1002l\e[?1003l\e[?1005l\e[?1006l\e[?1015l\e[?1016l'
          printf '\e[?1004l\e[?2004l\e[?2026l'
          # keyboard: app cursor keys, app keypad, kitty protocol, modifyOtherKeys
          printf '\e[?1l\e>\e[<99u\e[>4;0m'
          # visible default cursor, plain text attributes
          printf '\e[?25h\e[0 q\e[0m'
          # leave the alternate screen (tmux, vim) so scrollback works again
          (( rc == 255 )) && printf '\e[?1049l'
        fi
        return $rc
      }

    '';

  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file = {
    ".hammerspoon/init.lua".source =
      config.lib.file.mkFlakeSymlink ../../dotfiles/.hammerspoon-init.lua;
  };

}
