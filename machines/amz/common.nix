{ pkgs, ... }:
{
  imports = [ ];

  home.packages = with pkgs; [
#    poetry
#    uv
  ];

  programs.zsh = {
    shellAliases = {
      bb = "brazil-build";
      bbr = "brazil-build release";
    };
  };
}
