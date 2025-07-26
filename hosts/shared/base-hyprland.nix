{
  config,
  pkgs,
  ...
}:

{
  # Wofi launcher configuration - shared across all hosts
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
        border-radius: 0px;
      }

      #input {
        margin: 5px;
        border: none;
        color: #cdd6f4;
        background-color: #313244;
        border-radius: 0px;
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

  # Base Hyprland configuration - shared settings
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Input configuration - shared
      input = {
        kb_layout = "us";
        kb_options = "caps:escape";
        follow_mouse = 1;
        repeat_rate = 40;
        repeat_delay = 225;
        sensitivity = 0;
      };
      
      # General window management - follows default config
      general = {
        gaps_in = 5;
        gaps_out = 8;
        border_size = 1;
        "col.active_border" = "rgba(888888cc)";
        "col.inactive_border" = "rgba(44444488)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "master";
      };
      
      # Decoration - follows default config
      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      
      # Cursor configuration
      cursor = {
        inactive_timeout = 3;
        hide_on_key_press = true;
        default_monitor = "";
        no_hardware_cursors = false;
      };
      
      # Animations - follows default config structure
      animations = {
        enabled = true;
        
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };
      
      # Misc settings - follows default config
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };
      
      # Gestures - follows default config
      gestures = {
        workspace_swipe = false;
      };
      
      # Dark theme - shared
      env = [
        "GTK_THEME,Adwaita:dark"
        "QT_STYLE_OVERRIDE,adwaita-dark"
      ];
      
      exec-once = [
        "hyprpaper"
        "waybar"
        "gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'"
        "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
      ];
      
      # Key bindings - shared across all hosts
      "$mod" = "SUPER";
      
      bind = [
        # Basic window management
        "$mod, T, exec, alacritty"
        "$mod, Q, killactive,"
        "$mod, E, exec, nautilus"
        "$mod, B, exec, brave"
        "$mod, Space, exec, pkill wofi || wofi --show drun --allow-images --prompt 'Search:'"
        "$mod, D, exec, pkill wofi || wofi --show run --allow-images --prompt 'Run:'"
        "$mod SHIFT, Space, exec, pkill wofi || wofi --show window --allow-images --prompt 'Window:'"
        
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
        
        # Direct window management
        "$mod ALT, H, movewindow, l"
        "$mod ALT, L, movewindow, r"
        "$mod ALT, K, movewindow, u"
        "$mod ALT, J, movewindow, d"
        "$mod SHIFT, H, resizeactive, -50 0"
        "$mod SHIFT, L, resizeactive, 50 0"
        "$mod SHIFT, K, resizeactive, 0 -50"
        "$mod SHIFT, J, resizeactive, 0 50"
        
        # Wallpaper switching
        "$mod, W, exec, /home/trbiv/nixos-config/scripts/wallpaper-switcher.sh next"
        "$mod SHIFT, W, exec, /home/trbiv/nixos-config/scripts/wallpaper-switcher.sh prev"
      ];
      
      # Audio control bindings
      bindl = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        "$mod, F12, exec, /home/trbiv/nixos-config/scripts/audio-source-switch.sh"
      ];
      
      # Mouse bindings - shared
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };

  # Shared Waybar configuration - based on legacy-dotfiles
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        height = 30;
        
        modules-left = [ "hyprland/workspaces" "hyprland/mode" "tray" "cpu" "memory" "temperature" "backlight" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "mpris" "custom/wallpaper"  "wireplumber" "network" "idle_inhibitor" "battery" "clock" ];
        
        "hyprland/mode" = {
          format = " {}";
        };
        
        "hyprland/workspaces" = {
          format = "{name}";
          disable-scroll = true;
        };
        
        "hyprland/window" = {
          max-length = 80;
          tooltip = false;
        };
        
        mpris = {
          format = "{player_icon} {artist} - {title}";
          format-paused = "{player_icon} {artist} - {title}";
          player-icons = {
            default = "♪";
            mpv = "▶";
            vlc = "▶";
          };
          max-length = 60;
          interval = 1;
          tooltip = false;
        };
        
        clock = {
          format = "{:%a %d %b %H:%M}";
          tooltip = false;
        };
        
        battery = {
          format = "{capacity}% {icon}";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
          format-charging = "{capacity}% ";
          interval = 30;
          states = {
            warning = 25;
            critical = 10;
          };
          tooltip = false;
        };
        
        network = {
          format = "{icon}";
          format-alt = "{ipaddr}/{cidr} {icon}";
          format-alt-click = "click-right";
          format-icons = {
            wifi = ["" "" ""];
            ethernet = [""];
            disconnected = [""];
          };
          tooltip = false;
        };
        
        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = " Muted";
          format-icons = ["" "" "" ""];
          scroll-step = 5;
          on-click = "pavucontrol";
          tooltip = false;
        };
        
        backlight = {
          format = "{icon}";
          format-alt = "{percent}% {icon}";
          format-alt-click = "click-right";
          format-icons = ["" ""];
          on-scroll-down = "light -A 1";
          on-scroll-up = "light -U 1";
        };
        
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = false;
        };
        
        tray = {
          icon-size = 18;
        };
        
        cpu = {
          interval = 5;
          format = " {usage}%";
          tooltip = false;
        };
        
        memory = {
          interval = 5;
          format = " {percentage}%";
          tooltip-format = "Memory: {used:0.1f}G/{total:0.1f}G";
        };
        
        temperature = {
          interval = 5;
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = ["" "" "" "" ""];
          tooltip = false;
        };
        
        "custom/wallpaper" = {
          format = "  {}";
          exec = "/home/trbiv/nixos-config/scripts/wallpaper-switcher.sh current";
          on-click = "/home/trbiv/nixos-config/scripts/wallpaper-switcher.sh next && pkill -SIGRTMIN+8 waybar";
          on-click-right = "/home/trbiv/nixos-config/scripts/wallpaper-switcher.sh prev && pkill -SIGRTMIN+8 waybar";
          on-click-middle = "/home/trbiv/nixos-config/scripts/wallpaper-switcher.sh random && pkill -SIGRTMIN+8 waybar";
          signal = 8;
          interval = "once";
          tooltip-format = "Left click: Next wallpaper\nRight click: Previous wallpaper\nMiddle click: Random wallpaper";
        };
      };
    };
    
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: Sans;
        font-size: 15px;
        box-shadow: none;
        text-shadow: none;
        transition-duration: 0s;
      }
      
      window {
        color: rgba(217, 216, 216, 1);
        background: rgba(35, 31, 32, 0.85);
      }
      
      #workspaces {
        margin: 0 5px;
      }
      
      #workspaces button {
        padding: 0 5px;
        color: rgba(217, 216, 216, 0.4);
      }
      
      #workspaces button.visible {
        color: rgba(217, 216, 216, 1);
      }
      
      #workspaces button.focused {
        border-top: 3px solid rgba(217, 216, 216, 1);
        border-bottom: 3px solid rgba(217, 216, 216, 0);
      }
      
      #workspaces button.urgent {
        color: rgba(238, 46, 36, 1);
      }
      
      #mode, #battery, #network, #wireplumber, #idle_inhibitor, #backlight, #cpu, #memory, #temperature, #custom-wallpaper {
        margin: 0px 6px 0px 10px;
        min-width: 25px;
      }
      
      #mpris {
        margin: 0px 10px;
        color: rgba(217, 216, 216, 0.9);
      }
      
      #clock {
        margin: 0px 16px 0px 10px;
        min-width: 140px;
      }
      
      #battery.warning {
        color: rgba(255, 210, 4, 1);
      }
      
      #battery.critical {
        color: rgba(238, 46, 36, 1);
      }
      
      #battery.charging {
        color: rgba(217, 216, 216, 1);
      }
      
      #temperature.critical {
        color: rgba(238, 46, 36, 1);
      }
    '';
  };

  # Mako notification daemon configuration
  services.mako = {
    enable = true;
    settings = {
      background-color = "#1e1e2e";
      border-color = "#585b70";
      text-color = "#cdd6f4";
      border-radius = 5;
      border-size = 1;
      default-timeout = 5000;
    };
    # Disable music/media notifications
    extraConfig = ''
      [app-name="Spotify"]
      invisible=1
      
      [app-name="spotify"]
      invisible=1
      
      [app-name="mpv"]
      invisible=1
      
      [summary~=".*[Nn]ow [Pp]laying.*"]
      invisible=1
      
      [summary~=".*[Mm]usic.*"]
      invisible=1
    '';
  };

  # Hyprpaper configuration - wallpaper daemon
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      
      preload = [
        "/home/trbiv/nixos-config/assets/wallpapers/hyprland-bg.jpg"
      ];
      
      wallpaper = [
        ",/home/trbiv/nixos-config/assets/wallpapers/hyprland-bg.jpg"
      ];
    };
  };

  # Hyprland/Wayland tools - shared packages
  home.packages = with pkgs; [
    wofi
    waybar
    hyprpaper
    grim
    slurp
    pavucontrol
    libnotify
    playerctl
  ];
}
