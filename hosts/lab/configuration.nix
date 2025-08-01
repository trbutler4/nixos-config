# Minimal NixOS configuration for lab home server

{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lab";
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable SSH for remote management
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Enable Docker for Kubernetes
  virtualisation.docker.enable = true;

  # Configure Kubernetes
  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = "127.0.0.1";
    easyCerts = true;
    
    kubelet = {
      extraOpts = "--fail-swap-on=false";
    };
    
    clusterCidr = "10.1.0.0/16";
  };

  # Open necessary ports for Kubernetes
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      6443  # Kubernetes API server
      2379  # etcd client
      2380  # etcd peer
      10250 # kubelet
      10251 # kube-scheduler
      10252 # kube-controller-manager
    ];
    allowedUDPPorts = [
      8472  # flannel
    ];
  };

  time.timeZone = "America/Chicago";

  # Define a user account
  users.users.trbiv = {
    isNormalUser = true;
    description = "Thomas Robert Butler IV";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNmAMyn+wZCQo8QrH1VoZSfJlgq77wR+duA/Ho+m08X trbiv@nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIISI/0D5XZdi1mO90fSobWmSFMgkVz1Ff1mZ+AvG6Ri0 trbiv@desktop"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Essential server tools
    wget
    curl
    git
    vim
    htop
    tmux
    unzip
    ripgrep
    fzf
    zstd # for decompressing snapshots
    
    # Development basics
    gcc
    gnumake
    pkg-config
    openssl.dev
    protobuf
    zstd.dev
    docker
    
    # Terminal tools
    lazygit
    yazi
    
    # Editor
    neovim
    
    # Go development
    go
    gopls
    golangci-lint
    delve
    
    # Rust development
    rustup
    
    # Process management
    nodePackages.pm2
    
    # Kubernetes tools
    kubectl
    k9s
    kubernetes-helm
    k3s
  ];

  system.stateVersion = "25.05";
}
