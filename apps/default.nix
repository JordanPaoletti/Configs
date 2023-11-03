{ pkgs, ... }: {
  imports = [ ];

  home.packages = with pkgs; [ discord jetbrains-toolbox ];
}
