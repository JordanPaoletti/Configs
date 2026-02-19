{ pkgs, lib, ... }:
{
  imports = [ ];

  home.packages = with pkgs; [
   poetry
   uv
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = lib.mkForce "Jordan Paoletti";
        email = lib.mkForce "paoletjo@amazon.com";
      };
    };
  };

  programs.zsh = {
    shellAliases = {
      bb = "brazil-build";
      bbr = "brazil-build release";
    };
  };
}
