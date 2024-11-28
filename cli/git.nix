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
    userName = "Jordan Paoletti";
    userEmail = "jordanspaoletti@gmail.com";
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
    };
  };
}
