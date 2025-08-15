# Base template for creating basic dev environments with nix
# flake.nix must be added to vcs for nix develop to see it
# Run `echo "use flake" > .envrc` and then `direnv allow` if using direnv
# Example templates https://github.com/the-nix-way/dev-templates
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
        javaVersion = 23;
        java-overlay =
          final: prev:
          let
            jdk = prev."jdk${toString javaVersion}";
          in
          {
            inherit jdk;
            maven = prev.maven.override { jdk_headless = jdk; };
            gradle = prev.gradle.override { java = jdk; };
            lombok = prev.lombok.override { inherit jdk; };
          };
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            java-overlay
          ];
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          buildInputs = [
            # pkgs
            gcc
            gradle
            jdk
            maven
            ncurses
            patchelf
            zlib
          ];

          shellHook =
            let
              loadLombok = "-javaagent:${pkgs.lombok}/share/java/lombok.jar";
              prev = "\${JAVA_TOOL_OPTIONS:+ $JAVA_TOOL_OPTIONS}";
            in
            ''
              export JAVA_TOOL_OPTIONS="${loadLombok}${prev}"
            '';

        };
      }
    );
}
