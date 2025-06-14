# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

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

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.printing.enable = true;
  services.flatpak.enable = true;

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

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Essentials
    gcc
    vim
    git
    wget
    htop

    # GNOME stuff
    gnome-themes-extra
    gnome-tweaks
    adwaita-icon-theme
    gedit
    gnomeExtensions.tiling-shell
    gnomeExtensions.bing-wallpaper

    # Tools
    # neovim - now managed by nvf through home-manager
    helix
    zellij
    lazygit
    lazydocker
    yazi
    fastfetch
    unzip
    fzf
    gnumake

    # Programming
    nodejs_24
    bun
    yarn
    pnpm
    typescript
    typescript-language-server
    vscode-langservers-extracted
    python3
    rustc
    rustup
    cargo
    go
    gopls
    golangci-lint
    golangci-lint-langserver
    delve
    claude-code
    ruff
    python312Packages.jedi-language-server
    python312Packages.python-lsp-server

    # Apps
    brave
    zed-editor
    obs-studio
    spotify
    telegram-desktop
    alacritty
    ghostty
    libreoffice-still
    gimp3
    thunderbird

    # misc config
    vimPlugins.LazyVim
  ];

  virtualisation.docker = {
    enable = true;
  };

  system.stateVersion = "25.05"; # dont change
}

