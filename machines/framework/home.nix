{ pkgs, inputs, ... }:
{
  imports = [
    ../../modules/desktop/cli
    ../../modules/desktop/apps
  ];

  home = {
    username = "jordan";
    homeDirectory = "/home/jordan";
    flakePath = "/home/jordan/.config/home-manager";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    # Nix related packages
    nixfmt-rfc-style

    # machine specific packages
    zip
    unzip
    caligula

  ];

  home.sessionVariables = { };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Get desktop entries to populate on ubuntu
  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Setup Direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };
}
