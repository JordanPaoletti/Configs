{ pkgs, ... }:
{
  imports = [ ];

  home.packages = with pkgs; [
    # https://wiki.nixos.org/wiki/Jetbrains_Tools
    # requires a bit of work to get auth working, follow above guide
    jetbrains-toolbox

    ungoogled-chromium
    discord
    spotify
  ];
}
