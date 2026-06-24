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

  programs.lazygit = {
    enable = true;
    settings = {
    };
  };
}
