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
    let
      pkgsSource =
        sys:
        import nixpkgs {
          system = sys;
          config.allowUnfree = true;
        };
    in
    {
      nixosConfigurations = {
        framework = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/framework/configuration.nix
          ];
        };

        xps13 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/xps13/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "jordan@dev-pc" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsSource "x86_64-linux";
          modules = [
            ./machines/dev-pc/home.nix
            catppuccin.homeManagerModules.catppuccin
          ];
        };
        "jordan@framework" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsSource "x86_64-linux";
          modules = [
            ./machines/framework/home.nix
            catppuccin.homeManagerModules.catppuccin
          ];
        };
      };
    };
}
