{
  config,
  pkgs,
  ...
}:

{
  imports = [
    #../shared/nvf.nix
  ];

  home.username = "trbiv";
  home.homeDirectory = "/home/trbiv";
  home.stateVersion = "25.11";
  home.enableNixpkgsReleaseCheck = false;

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = "${config.home.homeDirectory}/.secrets/secrets.yaml";
    defaultSopsFormat = "yaml";
    validateSopsFiles = false;
    secrets = {
      # Server configurations
      "servers/suffix-labs/db-01/ip" = {
        path = "${config.home.homeDirectory}/.local/share/sops/suffix-labs-db01-ip";
      };
      "servers/ethchi/starknet-node/ip" = {
        path = "${config.home.homeDirectory}/.local/share/sops/ethchi-starknet-ip";
      };
    };
  };

  home.packages = with pkgs; [
    age
    sops
    # essential
    gcc
    vim
    git
    htop
    tmux
    cryptsetup
    openssl

    # Terminal Programs
    htop
    helix
    tmux
    zellij
    lazygit
    lazydocker
    yazi
    fastfetch
    unzip
    fzf
    gnumake
    claude-code
    asdf-vm
    postgresql
    wl-clipboard

    # GUI Apps
    brave
    zed-editor
    obs-studio
    spotify
    telegram-desktop
    alacritty
    ghostty
    libreoffice-still
    gimp3
    discord
    gedit
    albert
    zoom-us
    ledger-live-desktop

    #Nix
    nixd
    # Node/Typescript
    nodejs_24
    bun
    yarn
    pnpm
    typescript
    typescript-language-server
    vscode-langservers-extracted
    # Python
    python3
    uv
    # Go
    go
    gopls
    delve
    golangci-lint
    golangci-lint-langserver
    # Rust
    rustup
    # EVM
    foundry
    slither-analyzer
    solc
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "lambda";
    };
    shellAliases = {
      lg = "lazygit";
      z = "zellij";
      y = "yazi";
      nv = "nvim";
      # Server SSH aliases
      ssh-suffix-db = "ssh suffix-db";
      ssh-ethchi-starknet = "ssh ethchi-starknet";
    };
    initContent = ''
      export EDITOR=nvim
      export PATH="$HOME/.asdf/shims:$PATH"
      export PATH="$HOME/.starknet-foundry/target/release:$PATH"
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      # Suffix Labs DB Server
      Host suffix-db
        HostName $(cat ${config.sops.secrets."servers/suffix-labs/db-01/hostname".path} 2>/dev/null || cat ${config.sops.secrets."servers/suffix-labs/db-01/ip".path} 2>/dev/null || echo "")
        User root
        IdentityFile ${config.sops.secrets."servers/suffix-labs/db-01/ssh_key".path}
        StrictHostKeyChecking no
        UserKnownHostsFile /dev/null

      # Ethchi Starknet Node
      Host ethchi-starknet
        HostName $(cat ${config.sops.secrets."servers/ethchi/starknet-node/hostname".path} 2>/dev/null || cat ${config.sops.secrets."servers/ethchi/starknet-node/ip".path} 2>/dev/null || echo "")
        User root
        IdentityFile ${config.sops.secrets."servers/ethchi/starknet-node/ssh_key".path}
        StrictHostKeyChecking no
        UserKnownHostsFile /dev/null
    '';
  };

  programs.firefox.enable = true;

}
