{ config, pkgs, lib, ... }:
{
  options = {
    myAi = {
      enable = lib.mkEnableOptions "myAi";
    };
  };

  config = lib.mkIf config.myAi.enable {
    home.packages = with pkgs; [
      goose-cli
    ];
  };
}
