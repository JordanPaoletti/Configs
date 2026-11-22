{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Jordan Paoletti";
        email = "jordanspaoletti@gmail.com";
      };
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
    };
  };

  # The catppuccin/nix lazygit theme still uses the pre-0.66 `gui.authorColors`
  # key, which makes lazygit try (and fail) to migrate the read-only store file.
  # Inline the mocha/mauve theme with the new layout until upstream catches up.
  catppuccin.lazygit.enable = false;

  programs.lazygit = {
    enable = true;
    settings = {
      gui.theme = {
        activeBorderColor = [ "#cba6f7" "bold" ];
        inactiveBorderColor = [ "#a6adc8" ];
        searchingActiveBorderColor = [ "#f9e2af" ];
        optionsTextColor = [ "#89b4fa" ];
        selectedLineBgColor = [ "#313244" ];
        inactiveViewSelectedLineBgColor = [ "#6c7086" ];
        cherryPickedCommitFgColor = [ "#cba6f7" ];
        cherryPickedCommitBgColor = [ "#45475a" ];
        markedBaseCommitFgColor = [ "#89b4fa" ];
        markedBaseCommitBgColor = [ "#f9e2af" ];
        unstagedChangesColor = [ "#f38ba8" ];
        defaultFgColor = [ "#cdd6f4" ];
        authorColors = {
          "*" = "#b4befe";
        };
      };
    };
  };
}
