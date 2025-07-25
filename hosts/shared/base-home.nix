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
  home.stateVersion = "25.05";
  home.enableNixpkgsReleaseCheck = false;

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
      # Server SSH aliases - using wrapper scripts
      suffix-ssh = "ssh-suffix-starknet";
      ethchi-ssh = "ssh-ethchi-starknet";
      # Alias management
      aliases = "alias | fzf";
    };
    initContent = ''
      export EDITOR=nvim
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
  };

  programs.zellij = {
    enable = true;
    #enableZshIntegration = true;
    settings = {
      theme = "gruvbox-dark";
      default_layout = "compact";
      pane_frames = false;
      simplified_ui = true;
      show_startup_tips = false;
      themes = {
        everforest-dark-medium = {
          fg = "#d3c6aa";
          bg = "#2d353b";
          black = "#4a555b";
          red = "#ec5f67";
          green = "#a7c080";
          yellow = "#dbbc7f";
          blue = "#7fbbb3";
          magenta = "#d699b6";
          cyan = "#83c092";
          white = "#d3c6aa";
          orange = "#e67e80";
        };
        gruvbox-dark = {
          fg = "#ebdbb2";
          bg = "#282828";
          black = "#282828";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
          orange = "#d65d0e";
        };
      };
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "None";
        opacity = 0.90;
      };
      colors = {
        transparent_background_colors = true;
      };
    };
  };

  programs.ghostty = {
    enable = true;
    settings = {
      background-opacity = 0.85;
    };
  };

  programs.firefox.enable = true;


  # Create SSH wrapper scripts using writeShellScriptBin
  home.packages = let
    ssh-suffix-starknet = pkgs.writeShellScriptBin "ssh-suffix-starknet" ''
      IP=$(yq -r '.servers."suffix-labs"."starknet-node".ip' "${config.home.homeDirectory}/.secrets/secrets.yaml" 2>/dev/null || echo "")
      USER=$(yq -r '.servers.defaultUser' "${config.home.homeDirectory}/.secrets/secrets.yaml" 2>/dev/null || echo "root")
      if [ -z "$IP" ]; then
        echo "Error: Could not read suffix-labs server IP from secrets"
        exit 1
      fi
      exec ${pkgs.openssh}/bin/ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "$USER"@"$IP" "$@"
    '';
    
    ssh-ethchi-starknet = pkgs.writeShellScriptBin "ssh-ethchi-starknet" ''
      IP=$(yq -r '.servers.ethchi."starknet-node".ip' "${config.home.homeDirectory}/.secrets/secrets.yaml" 2>/dev/null || echo "")
      USER=$(yq -r '.servers.defaultUser' "${config.home.homeDirectory}/.secrets/secrets.yaml" 2>/dev/null || echo "root")
      if [ -z "$IP" ]; then
        echo "Error: Could not read ethchi server IP from secrets"
        exit 1
      fi
      exec ${pkgs.openssh}/bin/ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "$USER"@"$IP" "$@"
    '';
  in [ ssh-suffix-starknet ssh-ethchi-starknet ] ++ (with pkgs; [
    yq-go
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
    ripgrep
    jq
    doctl # digital ocean cli

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
    
    # Cursor theme
    vanilla-dmz
    
  ]);

  # Cursor theme configuration
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Additional Wayland cursor configuration
  home.sessionVariables = {
    XCURSOR_THEME = "Vanilla-DMZ";
    XCURSOR_SIZE = "24";
  };

}
