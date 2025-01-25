# Base template for creating basic dev environments with nix
# flake.nix must be added to vcs for nix develop to see it
# Run `echo "use flake" > .envrc` and then `direnv allow` if using direnv
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          buildInputs = [
            # pkgs
          ];
        };
      }
    );
}
