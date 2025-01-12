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
    }@inputs:
    {
      nixosConfigurations = {
        framework = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/framework/configuration.nix
            ./machines/framework/hardware-configuration.nix
          ];
        };

        xps13 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/xps13/configuration.nix
            ./machines/xps13/hardware-configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "jordan@dev-pc" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./machines/dev-pc/home.nix
            catppuccin.homeManagerModules.catppuccin
          ];
        };
        "jordan@framework" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./machines/framework/home.nix
            catppuccin.homeManagerModules.catppuccin
          ];
        };
      };
    };
}
