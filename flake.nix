{
  description = "Home Manager configuration of jordan";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      catppuccin,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        framework = pkgs.lib.nixosSystem {
          modules = [
            ./machines/framework/configuration.nix
            ./machines/framework/hardware-configuration.nix
            ./machines/framework/home.nix
          ];
        };

        xps13 = pkgs.lib.nixosSystem {
          modules = [
            ./machines/xps13/configuration.nix
            ./machines/xps13/hardware-configuration.nix
          ];
        };
      };
      homeConfigurations = {
        "jordan@dev-pc" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./machines/dev-pc/home.nix
            catppuccin.homeManagerModules.catppuccin
          ];
        };
        "jordan@framework" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./machines/framework/home.nix
            catppuccin.homeManagerModules.catppuccin
          ];
        };
      };
    };
}
