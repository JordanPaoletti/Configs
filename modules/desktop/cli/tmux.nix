{ config, pkgs, ... }:
{
  xdg.configFile."tmux/user.conf".source = config.lib.file.mkFlakeSymlink ../../../dotfiles/.tmux.conf;

  programs.tmux = {
    enable = true;
    extraConfig = ''
      unbind r
      bind-key r source-file ${config.xdg.configHome}/tmux/tmux.conf \; display-message "tmux.conf reloaded"

      source-file ${config.xdg.configHome}/tmux/user.conf

      run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux
    '';

    plugins = with pkgs.tmuxPlugins; [
      yank
      catppuccin
    ];
  };
}
