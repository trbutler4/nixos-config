{
  config,
  pkgs,
  ...
}:

{
  imports = [
    #../shared/nvf.nix
  ];

  # Username and homeDirectory should be set by the importing configuration
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
      ldo = "lazydocker";
      z = "zellij";
      y = "yazi";
      nv = "nvim";
      # Alias management
      aliases = "alias | fzf";
    };
    initContent = ''
      export EDITOR=nvim

      # Source environment variables from .env file if it exists
      if [ -f "$HOME/.secrets/.env" ]; then
        source "$HOME/.secrets/.env"
      fi
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
      Host suffix-lab
        HostName $SUFFIX_LAB_IP
        User $SUFFIX_LAB_USER

      Host ethchi-starknet
        HostName $ETHCHI_STARKNET_IP
        User $SERVERS_DEFAULT_USER
    '';
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
      keybinds.normal._children = [
        {
          bind = {
            _args = [ "Ctrl y" ];
            _children = [
              { SwitchToMode._args = [ "session" ]; }
            ];
          };
        }
      ];
      keybinds.unbind = [ "Ctrl o" ];
      themes = {
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
      };
    };
  };

  programs.ghostty = {
    enable = true;
  };

  programs.firefox.enable = true;

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox_dark_hard";

      editor = {
        line-number = "relative";
        color-modes = true;
        # rulers = [ 80 120 ];

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = {
          hidden = false;
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "register"
          ];
          center = [ "file-name" ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
          separator = "│";
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        lsp = {
          display-messages = true;
        };
      };
    };
  };

  programs.zed-editor = {
    enable = true;
    extensions = [
      "typescript"
      "rust"
      "go"
      "solidity"
      "cairo"
      "nix"
      "html"
    ];
    userSettings = {
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      vim_mode = true;
      ui_font_size = 14;
      buffer_font_size = 14;
      theme = {
        mode = "dark";
        light = "One Light";
        dark = "Gruvbox Dark Hard";
      };
    };
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      clock = true;
      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 7;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      ring-color = "bb00cc";
      key-hl-color = "880033";
      line-color = "00000000";
      inside-color = "00000088";
      separator-color = "00000000";
      grace = 2;
      fade-in = 0.2;
    };
  };

  home.packages = with pkgs; [
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
    kubectl # kubernetes cli
    k9s

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

    # Bluetooth
    blueman

    #Nix
    nixd
    nil
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
  ];

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
