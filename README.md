# General nix/homemanager configuration and other app configs and dotfiles

## Ref Links
* [layout inspiration](https://github.com/nathanregner/nix-config/tree/master)
* [home manager search](https://mipmip.github.io/home-manager-option-search/)
* [nixpkgs search](https://search.nixos.org/packages)

## helpful commands
```shell
# update config
home-manager switch

# update nixpkgs in flake
nix flake update
# run home-manager switch after

# nixfmt (from hm base directory)
nixfmt $(find . -name "*.nix")
```


## Getting home-manager installed
* [install multi-user version](https://nixos.org/manual/nix/stable/installation/installation#multi-user)
* [install home-manager with flakes](https://nix-community.github.io/home-manager/index.html#ch-nix-flakes)