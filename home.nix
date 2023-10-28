{ config, pkgs, ... }: {
    imports = [
        ./cli
    ];
    home.username = "jordan";
    home.homeDirectory = "/home/jordan";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.05";

    home.packages = [
      # cli
      pkgs.xclip

      # apps
      pkgs.jetbrains-toolbox
      pkgs.discord

      # nix
      nixfmt
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
