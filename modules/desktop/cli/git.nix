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
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
    };
  };
}
