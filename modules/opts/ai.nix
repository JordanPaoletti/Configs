{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    myAi = {
      enable = lib.mkEnableOption "myAi";
    };
  };

  config = lib.mkIf config.myAi.enable {
    home.packages = with pkgs; [
      goose-cli
    ];
  };
}
