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
    musnix = {
      url = "github:musnix/musnix";
    };
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

        xps15 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/xps15/configuration.nix
          ];
        };

        xps13 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/xps13/configuration.nix
          ];
        };

        dev-pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/dev-pc/configuration.nix
          ];
        };

        music = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/music/configuration.nix
            inputs.musnix.nixosModules.musnix
          ];
        };

      };

      homeConfigurations = {
        "jordan@dev-pc" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsSource "x86_64-linux";
          modules = [
            ./machines/dev-pc/home.nix
            catppuccin.homeModules.catppuccin
          ];
        };
        "jordan@xps15" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsSource "x86_64-linux";
          modules = [
            ./machines/xps15/home.nix
            catppuccin.homeModules.catppuccin
          ];
        };
        "jordan@framework" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsSource "x86_64-linux";
          modules = [
            ./machines/framework/home.nix
            catppuccin.homeModules.catppuccin
          ];
        };
        "jordan@music" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsSource "x86_64-linux";
          modules = [
            ./machines/music/home.nix
            catppuccin.homeModules.catppuccin
          ];
        };
        "paoletjo@7cf34de1a6e1" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsSource "aarch64-darwin";
          modules = [
            ./machines/amz/mac.nix
            catppuccin.homeModules.catppuccin
          ];
        };
        "paoletjo" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsSource "x86_64-linux";
          modules = [
            ./machines/amz/linux.nix
            catppuccin.homeModules.catppuccin
          ];
        };
      };
    };
}
