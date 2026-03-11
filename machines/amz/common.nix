{ pkgs, lib, ... }:
{
  imports = [ ];

  home.packages = with pkgs; [
    poetry
    uv
    ruby_3_4
    python3
    pipx
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
      bbc = "brazil-build clean";
      bbr = "brazil-build release";
      bsync = "brazil ws sync";
      edbb = "eda build brazil-build";
    };
  };
}
