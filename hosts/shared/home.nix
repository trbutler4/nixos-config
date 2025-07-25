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
        opacity = 0.85;
      };
      colors = {
        transparent_background_colors = true;
      };
    };
  };

  # Wofi launcher configuration
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
    };
    style = ''
      window {
        margin: 0px;
        border: 1px solid #1e1e2e;
        background-color: #1e1e2e;
        border-radius: 7px;
      }

      #input {
        margin: 5px;
        border: none;
        color: #cdd6f4;
        background-color: #313244;
        border-radius: 5px;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: #1e1e2e;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: #1e1e2e;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: #cdd6f4;
      }

      #entry:selected {
        background-color: #585b70;
      }

      #entry:selected #text {
        color: #cdd6f4;
      }
    '';
  };

  programs.firefox.enable = true;

  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Monitor configuration
      monitor = ",preferred,auto,auto";
      
      # Input configuration
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = 0;
      };
      
      # General window management
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };
      
      # Fast animations for responsive feel
      animations = {
        enabled = true;
        bezier = "myBezier, 0.23, 1, 0.32, 1";
        animation = [
          "windows, 1, 2, myBezier"
          "windowsOut, 1, 2, default, popin 80%"
          "fade, 1, 2, default"
          "workspaces, 1, 2, default"
        ];
      };
      
      # Dark theme and wallpaper
      env = [
        "GTK_THEME,Adwaita:dark"
        "QT_STYLE_OVERRIDE,adwaita-dark"
      ];
      
      exec-once = [
        "hyprpaper"
        "gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'"
        "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
      ];
      
      # Key bindings
      "$mod" = "SUPER";
      
      bind = [
        # Basic window management
        "$mod, T, exec, alacritty"
        "$mod, Q, killactive,"
        "$mod, E, exec, nautilus"
        "$mod, B, exec, brave-browser"
        "$mod, Space, exec, wofi --show drun --allow-images --prompt 'Search:'"
        "$mod, D, exec, wofi --show run --allow-images --prompt 'Run:'"
        "$mod SHIFT, Space, exec, wofi --show window --allow-images --prompt 'Window:'"
        
        # Logout options
        "$mod SHIFT, Q, exit,"
        "$mod CTRL SHIFT, Q, exec, hyprctl dispatch exit"
        
        # Move focus with vim keys
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        
        # Switch workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        
        # Move active window to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"    
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        
        # Window manipulation
        "$mod, S, togglesplit,"
        "$mod, O, layoutmsg, orientationnext"
        "$mod, G, togglefloating,"
        "$mod, M, fullscreen, 0"
        "$mod CTRL, H, moveactive, exact 0 0"
        "$mod CTRL, L, moveactive, exact 50% 0"
        
        # Direct window management (without adjustment mode for now)
        "$mod ALT, H, movewindow, l"
        "$mod ALT, L, movewindow, r"
        "$mod ALT, K, movewindow, u"
        "$mod ALT, J, movewindow, d"
        "$mod SHIFT, H, resizeactive, -50 0"
        "$mod SHIFT, L, resizeactive, 50 0"
        "$mod SHIFT, K, resizeactive, 0 -50"
        "$mod SHIFT, J, resizeactive, 0 50"
      ];
      
      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };

  # Hyprpaper wallpaper configuration
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      
      preload = [
        "~/Pictures/wallpapers/mountain-far.jpg"
      ];
      
      wallpaper = [
        ",~/Pictures/wallpapers/mountain-far.jpg"
      ];
    };
  };

  # Waybar configuration
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 4;
        
        modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "tray" "network" "battery" "clock" ];
        
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "urgent" = "";
            "focused" = "";
            "default" = "";
          };
        };
        
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
        };
        
        tray = {
          spacing = 10;
        };
        
        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };
        
        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}. {bandwidthUpBits} / {bandwidthDownBits}";
        };
      };
    };
    
    style = ''
      * {
        font-family: "0xProto Mono", monospace;
        font-size: 13px;
      }
      
      window#waybar {
        background-color: rgba(43, 48, 59, 0.8);
        border-bottom: 3px solid rgba(100, 114, 125, 0.5);
        color: #ffffff;
        transition-property: background-color;
        transition-duration: .5s;
      }
      
      button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: 0;
      }
      
      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #ffffff;
      }
      
      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
      }
      
      #workspaces button.focused {
        background-color: #64727D;
        box-shadow: inset 0 -3px #ffffff;
      }
      
      #workspaces button.urgent {
        background-color: #eb4d4b;
      }
      
      #mode {
        background-color: #64727D;
        border-bottom: 3px solid #ffffff;
      }
      
      #clock,
      #battery,
      #network,
      #tray {
        padding: 0 10px;
        color: #ffffff;
      }
      
      #window {
        color: #64727D;
      }
      
      #battery.charging, #battery.plugged {
        color: #26A65B;
      }
      
      #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      
      @keyframes blink {
        to {
          background-color: #ffffff;
          color: #000000;
        }
      }
    '';
  };

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
    
    # Hyprland/Wayland tools
    wofi
    waybar
    mako
    hyprpaper
    grim
    slurp
  ]);

}
