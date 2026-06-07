{
  pkgs,
  ...
}:
{
  imports = [ ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
  networking.hostName = "air";

  system.primaryUser = "jordan";

  system.stateVersion = 7;
}
