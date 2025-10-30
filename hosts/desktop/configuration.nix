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

  networking.hostName = "desktop"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Open port 80 for Caddy (accessible via tailscale)
  networking.firewall.allowedTCPPorts = [ 80 ];

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

  # Font configuration
  fonts = {
    packages = with pkgs; [
      # System will look for fonts in ~/.local/share/fonts automatically
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "0xProto" ];
        sansSerif = [ "0xProto" ];
        monospace = [ "0xProto Mono" ];
      };
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.xserver.enable = true;

  programs.nix-ld.enable = true;
  
  # COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  
  # Hyprland window manager
  programs.hyprland.enable = true;
  services.printing.enable = true;
  services.flatpak.enable = true;
  
  services.openssh.enable = true;

  # Caddy reverse proxy for local services over tailscale
  services.caddy = {
    enable = true;

    # Default virtual host (responds to all requests)
    virtualHosts."http://".extraConfig = ''
      # Vite on /vite path
      handle_path /vite* {
        reverse_proxy localhost:5173
      }

      # Storybook on /storybook path
      handle_path /storybook* {
        reverse_proxy localhost:6006
      }

      # Default handler for root (returns 404)
      handle {
        respond 404
      }
    '';
  };

  # Audio configuration - PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Bluetooth configuration
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # manually setting timezone -- for some reason automatic timezone was having troubles.
  time.timeZone = "America/Chicago";
  services.automatic-timezoned.enable = false;

  services.tailscale.enable = true;

  # Temporarily disabled due to OpenJDK 8 cycle detection bug
  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "trbiv" "root" ];
  # virtualisation.virtualbox.host.enableKvm = true;
  # virtualisation.virtualbox.host.addNetworkInterface = false;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.trbiv = {
    isNormalUser = true;
    description = "Thomas Robert Butler IV";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
      "kvm"
    ];
    shell = pkgs.zsh;
  };

  users.users.guest = {
    isNormalUser = true;
    description = "Guest User";
    extraGroups = [ "networkmanager" ];
    shell = pkgs.zsh;
    hashedPassword = null; # No password login (more secure than empty string)
    home = "/home/guest";
    createHome = true;
  };

  # needed for udev rules to connect to ledger device
  hardware.ledger.enable = true;

  # Enable NTFS support for external drives
  boot.supportedFilesystems = [ "ntfs" ];

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget

    # Network management
    networkmanagerapplet

    # Desktop theming
    adwaita-icon-theme

    # Nix stuff
    home-manager
  ];

  virtualisation.docker = {
    enable = true;
  };


  # Enable virt-manager for GUI VM management
  programs.virt-manager.enable = true;


  system.stateVersion = "25.05";
}
