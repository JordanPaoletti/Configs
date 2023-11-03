{ pkgs, ... }: {
  imports = [ ];

  home.packages = with pkgs; [
    # basic gui apps
    jetbrains-toolbox

    # https://nixos.wiki/wiki/Discord
    discord
  ];
}
