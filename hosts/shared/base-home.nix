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

      # Claude Code directory-based config switching
      claude() {
        if [[ $PWD == */Projects/oku/* || $PWD == */Projects/oku ]]; then
          CLAUDE_CODE_CONFIG_DIR="/etc/claude-code" command claude "$@"
        else
          command claude "$@"
        fi
      }
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Thomas Butler";
    userEmail = "trbiv@proton.me";
    extraConfig = {
      pull = {
        rebase = false;
      };
    };
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

  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "monospace:size=10";
        dpi-aware = "yes";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      colors = {
        # Gruvbox dark theme
        background = "282828";
        foreground = "ebdbb2";

        regular0 = "282828";   # black
        regular1 = "cc241d";   # red
        regular2 = "98971a";   # green
        regular3 = "d79921";   # yellow
        regular4 = "458588";   # blue
        regular5 = "b16286";   # magenta
        regular6 = "689d6a";   # cyan
        regular7 = "a89984";   # white

        bright0 = "928374";    # bright black
        bright1 = "fb4934";    # bright red
        bright2 = "b8bb26";    # bright green
        bright3 = "fabd2f";    # bright yellow
        bright4 = "83a598";    # bright blue
        bright5 = "d3869b";    # bright magenta
        bright6 = "8ec07c";    # bright cyan
        bright7 = "ebdbb2";    # bright white
      };
    };
  };

  programs.firefox.enable = true;

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox-dark-hard-transparent";

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
    themes = {
      gruvbox-dark-hard-transparent = {
        # Base colors (gruvbox dark hard palette)
        "ui.background" = { }; # Transparent background
        "ui.background.separator" = "#1d2021";
        "ui.cursor" = {
          fg = "#1d2021";
          bg = "#ebdbb2";
        };
        "ui.cursor.normal" = {
          fg = "#1d2021";
          bg = "#ebdbb2";
        };
        "ui.cursor.insert" = {
          fg = "#1d2021";
          bg = "#83a598";
        };
        "ui.cursor.select" = {
          fg = "#1d2021";
          bg = "#d3869b";
        };
        "ui.cursor.match" = {
          fg = "#1d2021";
          bg = "#fe8019";
          modifiers = [ "bold" ];
        };
        "ui.cursor.primary" = {
          fg = "#1d2021";
          bg = "#ebdbb2";
        };
        "ui.cursorline.primary" = {
          bg = "#3c3836";
        };
        "ui.cursorline.secondary" = {
          bg = "#3c3836";
        };
        "ui.selection" = {
          bg = "#504945";
        };
        "ui.selection.primary" = {
          bg = "#504945";
        };
        "ui.linenr" = "#665c54";
        "ui.linenr.selected" = "#ebdbb2";
        "ui.statusline" = {
          fg = "#ebdbb2";
          bg = "#3c3836";
        };
        "ui.statusline.inactive" = {
          fg = "#a89984";
          bg = "#282828";
        };
        "ui.statusline.normal" = {
          fg = "#1d2021";
          bg = "#a89984";
        };
        "ui.statusline.insert" = {
          fg = "#1d2021";
          bg = "#83a598";
        };
        "ui.statusline.select" = {
          fg = "#1d2021";
          bg = "#d3869b";
        };
        "ui.statusline.separator" = "#504945";
        "ui.popup" = {
          fg = "#ebdbb2";
          bg = "#3c3836";
        };
        "ui.window" = "#504945";
        "ui.help" = {
          fg = "#ebdbb2";
          bg = "#3c3836";
        };
        "ui.text" = "#ebdbb2";
        "ui.text.focus" = "#ebdbb2";
        "ui.menu" = {
          fg = "#ebdbb2";
          bg = "#3c3836";
        };
        "ui.menu.selected" = {
          fg = "#1d2021";
          bg = "#83a598";
        };
        "ui.virtual.whitespace" = "#504945";
        "ui.virtual.ruler" = "#504945";
        "ui.virtual.inlay-hint" = {
          fg = "#928374";
          bg = "#3c3836";
        };

        # Syntax highlighting
        "comment" = "#928374";
        "constant" = "#d3869b";
        "constant.numeric" = "#d3869b";
        "constant.builtin" = "#d3869b";
        "constant.character.escape" = "#fe8019";
        "string" = "#b8bb26";
        "string.regexp" = "#b8bb26";
        "string.special" = "#fe8019";
        "character" = "#d3869b";
        "type" = "#fabd2f";
        "type.builtin" = "#fabd2f";
        "constructor" = "#83a598";
        "function" = "#b8bb26";
        "function.builtin" = "#fe8019";
        "function.macro" = "#8ec07c";
        "variable" = "#ebdbb2";
        "variable.builtin" = "#fe8019";
        "variable.parameter" = "#ebdbb2";
        "variable.other.member" = "#ebdbb2";
        "label" = "#fb4934";
        "punctuation" = "#928374";
        "punctuation.delimiter" = "#928374";
        "punctuation.bracket" = "#ebdbb2";
        "keyword" = "#fb4934";
        "keyword.control" = "#fb4934";
        "keyword.operator" = "#fe8019";
        "keyword.directive" = "#8ec07c";
        "operator" = "#fe8019";
        "tag" = "#83a598";
        "attribute" = "#fabd2f";
        "namespace" = "#fabd2f";
        "module" = "#fabd2f";
        "special" = "#fe8019";

        # Diagnostics
        "diagnostic.error" = {
          underline = {
            color = "#fb4934";
            style = "curl";
          };
        };
        "diagnostic.warning" = {
          underline = {
            color = "#fabd2f";
            style = "curl";
          };
        };
        "diagnostic.info" = {
          underline = {
            color = "#83a598";
            style = "curl";
          };
        };
        "diagnostic.hint" = {
          underline = {
            color = "#8ec07c";
            style = "curl";
          };
        };

        # Diff
        "diff.plus" = "#b8bb26";
        "diff.minus" = "#fb4934";
        "diff.delta" = "#fe8019";

        # Git
        "markup.heading" = "#b8bb26";
        "markup.list" = "#fb4934";
        "markup.bold" = {
          fg = "#ebdbb2";
          modifiers = [ "bold" ];
        };
        "markup.italic" = {
          fg = "#ebdbb2";
          modifiers = [ "italic" ];
        };
        "markup.strikethrough" = {
          modifiers = [ "crossed_out" ];
        };
        "markup.link.url" = {
          fg = "#83a598";
          modifiers = [ "underlined" ];
        };
        "markup.link.text" = "#d3869b";
        "markup.quote" = "#928374";
        "markup.raw" = "#8ec07c";
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

    # additional COSMIC stuff
    cosmic-bg
    cosmic-wallpapers
    cosmic-screenshot
    cosmic-randr

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
    bat
    awscli

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
    zoom-us
    ledger-live-desktop
    gnome-disk-utility

    # Bluetooth
    blueman

    #Nix
    nodejs_24
    bun
    yarn
    pnpm
    python3
    go
    rustup
    foundry
  ];
}
