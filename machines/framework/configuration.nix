# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/general-config.nix
    ../../modules/nixos/intellij-dlls.nix
  ];

  environment.systemPackages = with pkgs; [
    mullvad-vpn

    gnomeExtensions.worksets
  ];

  programs.steam = {
    enable = true;
  };

  services.mullvad-vpn.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jordan = {
    isNormalUser = true;
    description = "jordan";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [ home-manager ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-9d646b34-8624-4f0e-a9a6-5232b6f873af".device =
    "/dev/disk/by-uuid/9d646b34-8624-4f0e-a9a6-5232b6f873af";

  # Enable networking
  networking.hostName = "framework"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Enable Tailscale
  services.tailscale.enable = true;

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
