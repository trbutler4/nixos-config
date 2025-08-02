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
        gaps_in = 3;
        gaps_out = 6;
        border_size = 0;
        resize_on_border = false;
        allow_tearing = false;
        layout = "master";
      };
      
      # Decoration - follows default config
      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 0.9;
        
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
        "nm-applet"
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
        
        # Toggle waybar
        "$mod, F11, exec, pkill -SIGUSR1 waybar"
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

      # Window rules for clean appearance
      windowrulev2 = [
        "bordersize 0,class:.*"
        "rounding 8,class:.*"
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
        height = 26;
        
        modules-left = [ "hyprland/workspaces"  "cpu" "memory" "temperature" "backlight" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "custom/wallpaper" "bluetooth" "wireplumber" "battery" "tray" "clock" ];
        
        
        "hyprland/workspaces" = {
          format = "{name}";
          disable-scroll = true;
        };
        
        "hyprland/window" = {
          max-length = 80;
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
        
        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = " Muted";
          format-icons = ["" "" "" ""];
          scroll-step = 5;
          on-click = "pavucontrol";
          tooltip = false;
        };
        
        tray = {
          icon-size = 18;
          spacing = 6;
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
          format = "   ";
          exec = "/home/trbiv/nixos-config/scripts/wallpaper-switcher.sh current";
          on-click = "/home/trbiv/nixos-config/scripts/wallpaper-selector.sh";
          on-click-right = "/home/trbiv/nixos-config/scripts/wallpaper-selector.sh";
          on-click-middle = "/home/trbiv/nixos-config/scripts/wallpaper-selector.sh";
          signal = 8;
          interval = "once";
          tooltip-format = "Click: Open wallpaper selector";
        };

        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-off = "󰂲";
          format-no-controller = "󰂲";
          interval = 30;
          on-click = "blueman-manager";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };
      };
    };
    
    style = ''
      * {
        border: none;
        border-radius: 1px;
        font-family: "0xProto", monospace;
        font-size: 16px;
        font-weight: 500;
        box-shadow: none;
        text-shadow: none;
        transition-duration: 200ms;
      }
      
      window {
        color: #d4d4d8;
        background: transparent;
        border-radius: 0;
      }
      
      /* Left modules with separators */
      #workspaces {
        margin: 4px 10px 0px 6px;
        padding: 0 2px;
        background: rgba(39, 39, 42, 0.8);
        border: 1px solid rgba(63, 63, 70, 0.3);
        border-radius: 8px;
      }
      
      #workspaces button {
        padding: 0px 3px;
        margin: 0;
        color: rgba(212, 212, 216, 0.6);
        border-radius: 6px;
        transition: all 200ms ease;
      }
      
      #workspaces button.visible {
        color: #d4d4d8;
        background: rgba(63, 63, 70, 0.6);
      }
      
      #workspaces button.focused {
        color: #ffffff;
        background: rgba(99, 102, 241, 0.8);
        box-shadow: 0 2px 8px rgba(99, 102, 241, 0.3);
      }
      
      #workspaces button.urgent {
        color: #ef4444;
        background: rgba(239, 68, 68, 0.2);
      }
      
      /* System info modules - left side */
      #cpu, #memory, #temperature, #backlight {
        margin: 4px 4px 0px 4px;
        padding: 0 2px;
        background: rgba(39, 39, 42, 0.8);
        border: 1px solid rgba(63, 63, 70, 0.3);
        border-radius: 8px;
        min-width: 26px;
        color: #d4d4d8;
      }
      
      #cpu {
        color: #d4d4d8;
      }
      
      #memory {
        color: #d4d4d8;
      }
      
      #temperature {
        color: #d4d4d8;
      }
      
      #backlight {
        color: #d4d4d8;
      }
      
      /* Center window title */
      #window {
        margin: 4px 12px 0px 12px;
        padding: 0 4px;
        background: rgba(39, 39, 42, 0.8);
        border: 1px solid rgba(63, 63, 70, 0.3);
        border-radius: 8px;
        color: #a1a1aa;
        font-weight: 400;
      }
      
      /* Right modules with separators */
      #custom-wallpaper, #bluetooth, #wireplumber, #battery, #tray, #clock {
        margin: 4px 4px 0px 4px;
        padding: 0 2px;
        background: rgba(39, 39, 42, 0.8);
        border: 1px solid rgba(63, 63, 70, 0.3);
        border-radius: 8px;
        min-width: 20px;
        color: #d4d4d8;
      }
      
      #custom-wallpaper {
        color: #d4d4d8;
        margin: 4px 4px 0px 6px;
      }
      
      #bluetooth {
        color: #d4d4d8;
      }
      
      #wireplumber {
        color: #d4d4d8;
      }
      
      #battery {
        color: #d4d4d8;
        min-width: 60px;
      }
      
      #tray {
        background: rgba(39, 39, 42, 0.8);
        border: 1px solid rgba(63, 63, 70, 0.3);
        padding: 0 2px;
      }
      
      #clock {
        margin: 4px 6px 0px 4px;
        padding: 0 3px;
        background: rgba(39, 39, 42, 0.8);
        border: 1px solid rgba(63, 63, 70, 0.3);
        color: #d4d4d8;
        font-weight: 600;
        min-width: 70px;
      }
      
      /* Battery states */
      #battery.warning {
        color: #f59e0b;
        border-color: rgba(245, 158, 11, 0.8);
        border-width: 2px;
      }
      
      #battery.critical {
        color: #ef4444;
        border-color: rgba(239, 68, 68, 0.8);
        border-width: 2px;
        animation: blink 1s linear infinite alternate;
      }
      
      #battery.charging {
        color: #10b981;
        border-color: rgba(16, 185, 129, 0.8);
        border-width: 2px;
      }
      
      #temperature.critical {
        color: #ef4444;
        border-color: rgba(239, 68, 68, 0.8);
        border-width: 2px;
        animation: blink 1s linear infinite alternate;
      }
      
      @keyframes blink {
        to {
          opacity: 0.5;
        }
      }
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
    blueman
  ];
}
