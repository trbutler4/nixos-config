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
      theme = "everforest-dark-medium";
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
      };
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "None";
        opacity = 1.0;
      };
    };
  };

  programs.firefox.enable = true;

  # Systemd service to watch for wallpaper changes and update Alacritty
  systemd.user.services.alacritty-wallpaper-sync = {
    Unit = {
      Description = "Sync Alacritty background with GNOME wallpaper";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "sync-alacritty-wallpaper" ''
        ${pkgs.glib}/bin/gsettings get org.gnome.desktop.background picture-uri | while read -r wallpaper_uri; do
          wallpaper_path=$(echo "$wallpaper_uri" | sed 's/^.file:\/\///' | sed 's/.$//')
          if [ -f "$wallpaper_path" ]; then
            config_file="$HOME/.config/alacritty/alacritty.toml"
            mkdir -p "$(dirname "$config_file")"
            cat > "$config_file" << EOF
[window]
decorations = "None"
opacity = 1.0

[window.background_image]
path = "$wallpaper_path"
opacity = 0.3
EOF
            echo "Updated Alacritty wallpaper to: $wallpaper_path"
            # Restart any running alacritty instances
            ${pkgs.procps}/bin/pkill -USR1 alacritty || true
          fi
        done
      ''}";
    };
  };

  # Timer to periodically check for wallpaper changes
  systemd.user.timers.alacritty-wallpaper-sync = {
    Unit = {
      Description = "Timer for Alacritty wallpaper sync";
    };
    Timer = {
      OnBootSec = "30s";
      OnUnitActiveSec = "30s";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };


  # Create SSH wrapper scripts and wallpaper sync script using writeShellScriptBin
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

    update-alacritty-wallpaper = pkgs.writeShellScriptBin "update-alacritty-wallpaper" ''
      CONFIG_FILE="$HOME/.config/alacritty/alacritty.toml"
      WALLPAPER_URI=$(${pkgs.glib}/bin/gsettings get org.gnome.desktop.background picture-uri)
      WALLPAPER_PATH=$(echo "$WALLPAPER_URI" | sed 's/^.file:\/\///' | sed 's/.$//') 
      
      if [ -f "$WALLPAPER_PATH" ]; then
        mkdir -p "$(dirname "$CONFIG_FILE")"
        cat > "$CONFIG_FILE" << EOF
[window]
decorations = "None"
opacity = 1.0

[window.background_image]
path = "$WALLPAPER_PATH"
opacity = 0.3
EOF
        echo "Updated Alacritty wallpaper to: $WALLPAPER_PATH"
      else
        echo "Wallpaper file not found: $WALLPAPER_PATH"
      fi
    '';
  in [ ssh-suffix-starknet ssh-ethchi-starknet update-alacritty-wallpaper ] ++ (with pkgs; [
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
  ]);

}
