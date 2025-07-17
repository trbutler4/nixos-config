# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "yoga"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  services.printing.enable = true;
  services.flatpak.enable = true;

  # manually setting timezone -- for some reason automatic timezone was having troubles.
  time.timeZone = "America/Chicago";
  services.automatic-timezoned.enable = false;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "trbiv" "root" ];
  virtualisation.virtualbox.host.enableKvm = true;
  virtualisation.virtualbox.host.addNetworkInterface = false;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.trbiv = {
    isNormalUser = true;
    description = "Thomas Robert Butler IV";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  # needed for udev rules to connect to ledger device
  hardware.ledger.enable = true;

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget

    # GNOME stuff
    gnome-themes-extra
    gnome-tweaks
    adwaita-icon-theme

    # Nix stuff
    home-manager
  ];

  services.udev.packages = [ pkgs.gnome-settings-daemon ];

  virtualisation.docker = {
    enable = true;
  };


  system.stateVersion = "25.11";
}
