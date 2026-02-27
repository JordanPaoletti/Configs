{ pkgs, lib, ... }:
{
  imports = [ ];

  home.packages = with pkgs; [
    poetry
    uv
    ruby_3_4
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = lib.mkForce "Jordan Paoletti";
        email = lib.mkForce "paoletjo@amazon.com";
      };
      pull = {
        rebase = true;
      };
    };
  };

  programs.zsh = {
    shellAliases = {
      bb = "brazil-build";
      bbr = "brazil-build release";
      edbb = "eda build brazil-build";
    };
  };
}
