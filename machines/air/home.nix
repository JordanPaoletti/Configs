{ config, pkgs, ... }:

{
  imports = [
    ../../modules/desktop/cli
    ../../modules/lib
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "jordan";
    homeDirectory = "/Users/jordan";
    flakePath = "/Users/jordan/.config/home-manager";
  };

  programs.zsh = {
    shellAliases = {
      nds = "sudo darwin-rebuild switch --flake ~/.config/home-manager";
    };
    envExtra = ''
      export PATH="/Users/$USER/.local/bin:$PATH"
      export PATH="/Users/$USER/.toolbox/bin:$PATH"
      export PATH="/Users/$USER/dev/scripts/shell:$PATH"
      export DOCKER_HOST=unix:///Applications/Finch/lima/data/finch/sock/finch.sock
    '';

    initContent = ''
      # eval $(brew shellenv)

      # stop mac updates from breaking nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

    '';

  };

  home.packages = with pkgs; [
    # system
    nerd-fonts.jetbrains-mono
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;
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
