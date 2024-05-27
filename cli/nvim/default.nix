{ config, pkgs, ... }:
{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        extraConfig = builtins.readFile ./init.vim;
        plugins = with pkgs.vimPlugins; [ lazy-nvim ];
    };

    programs.zsh.shellAliases.vimdiff = "nvim -d";
}