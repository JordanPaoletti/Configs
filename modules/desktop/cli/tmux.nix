{ config, pkgs, ... }:
{
  xdg.configFile."tmux/user.conf".source =
    config.lib.file.mkFlakeSymlink ../../../dotfiles/.tmux.conf;

  programs.tmux = {
    enable = true;
    extraConfig = ''
      unbind r
      bind-key r source-file ${config.xdg.configHome}/tmux/tmux.conf \; display-message "tmux.conf reloaded"

      source-file ${config.xdg.configHome}/tmux/user.conf


      set -g default-terminal "tmux-256color"
      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_window_status_style "rounded"
      set -g @catppuccin_window_default_text "#W"
      set -g @catppuccin_window_current_text "#W"
      set -g @catppuccin_window_text "#W"
      set-window-option -g automatic-rename off

      # set -g @catppuccin_window_left_separator ""
      # set -g @catppuccin_window_right_separator " "
      # set -g @catppuccin_window_middle_separator " █"
      # set -g @catppuccin_window_number_position "right"
      #
      # set -g @catppuccin_window_default_fill "number"
      #
      # set -g @catppuccin_window_current_fill "number"
      
      # set -g @catppuccin_status_modules_right "directory user host session"
      # set -g @catppuccin_status_left_separator  " "
      # set -g @catppuccin_status_right_separator ""
      # set -g @catppuccin_status_fill "icon"
      # set -g @catppuccin_status_connect_separator "no"

      # set -g @catppuccin_directory_text "#{pane_current_path}"

      run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux
    '';

    plugins = with pkgs.tmuxPlugins; [
      yank
      catppuccin
    ];
  };
}
