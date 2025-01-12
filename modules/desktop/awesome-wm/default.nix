{ config, ... }:
{
  xdg.configFile."awesome".source = config.lib.file.mkFlakeSymlink ./awesome;
}
