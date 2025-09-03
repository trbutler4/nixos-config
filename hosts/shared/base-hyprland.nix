{
  config,
  pkgs,
  ...
}:

let
  themes = import ./themes/default.nix;
  currentTheme = themes.${themes.current};
in
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
      matching = "fuzzy";
      sort_order = "default";
      gtk_dark = true;
      dynamic_lines = true;
    };
    style = ''
      window {
        margin: 0px;
        border: 1px solid ${currentTheme.wofi.window_border};
        background-color: ${currentTheme.wofi.window_bg};
        border-radius: 0px;
      }

      #input {
        margin: 5px;
        border: none;
        color: ${currentTheme.wofi.input_fg};
        background-color: ${currentTheme.wofi.input_bg};
        border-radius: 0px;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: ${currentTheme.wofi.window_bg};
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: ${currentTheme.wofi.window_bg};
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: ${currentTheme.wofi.text_fg};
      }

      #entry:selected {
        background-color: ${currentTheme.wofi.entry_selected_bg};
      }

      #entry:selected #text {
        color: ${currentTheme.wofi.entry_selected_fg};
      }
    '';
  };

  # Base Hyprland configuration - shared settings
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      # Source nwg-displays generated configuration if they exist
      source = ~/.config/hypr/monitors.conf
      source = ~/.config/hypr/workspaces.conf
    '';
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

      # General window management - optimized with borders for active window
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;  # Add border to show active window
        "col.active_border" = "rgb(${builtins.substring 1 6 currentTheme.colors.fg0})";
        "col.inactive_border" = "rgb(${builtins.substring 1 6 currentTheme.colors.bg2})";
        resize_on_border = false;
        allow_tearing = false;
        layout = "master";
      };

      # Decoration - optimized for performance
      decoration = {
        active_opacity = 1.0;  # No transparency for better performance
        inactive_opacity = 1.0;  # No transparency for inactive windows

        shadow = {
          enabled = false;  # Disable shadows for better performance
          range = 4;
          render_power = 3;
          color = "rgba(${builtins.substring 1 6 currentTheme.colors.bg1}ee)";
        };

        blur = {
          enabled = false;  # Disable blur for significant performance gain
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

      # Performance optimizations
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        vfr = true;  # Variable frame rate for better performance
        vrr = 0;  # Disable VRR if not needed
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        enable_swallow = false;
        swallow_regex = "";
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
      };

      # Debug settings for performance monitoring (optional)
      debug = {
        damage_tracking = 2;  # Full damage tracking for better performance
        disable_logs = true;  # Disable logs for performance
        disable_time = true;  # Disable time logging
      };

      # Animations - minimal for maximum performance
      animations = {
        enabled = false;  # Disable all animations for maximum performance
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
        "swayidle -w timeout 1200 'swaylock' timeout 1800 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock'"
        "gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'"
        "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
      ];

      # Key bindings - shared across all hosts
      "$mod" = "SUPER";

      bind = [
        # Basic window management
        "$mod, T, exec, alacritty"
        "$mod, Q, killactive,"
        "$mod, E, exec, cosmic-files"
        "$mod, B, exec, brave"
        "$mod, Space, exec, pkill wofi || wofi --show drun --allow-images --prompt 'Search:'"
        "$mod, D, exec, pkill wofi || wofi --show run --allow-images --prompt 'Run:'"
        "$mod SHIFT, Space, exec, pkill wofi || wofi --show window --allow-images --prompt 'Window:'"

        # Logout options
        "$mod SHIFT, Q, exit,"
        "$mod CTRL SHIFT, Q, exec, hyprctl dispatch exit"

        # PopOS-style window focus (vim keys)
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        
        # Switch to last accessed window (across workspaces)
        "$mod, Tab, focuscurrentorlast,"

        # PopOS-style workspace navigation (using Page Up/Down to avoid conflicts)
        "$mod, Page_Up, workspace, e+1"
        "$mod, Page_Down, workspace, e-1"

        # Direct workspace access (keep existing)
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

        # PopOS-style window movement between workspaces (using Page Up/Down)
        "$mod SHIFT, Page_Up, movetoworkspace, e+1"
        "$mod SHIFT, Page_Down, movetoworkspace, e-1"

        # Direct window movement (keep existing)
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

        # PopOS-style adjustment mode and tiling controls
        "$mod, A, submap, adjustment"
        "$mod, Y, exec, hyprctl keyword general:layout master && notify-send 'Auto-tiling enabled'"
        "$mod SHIFT, Y, exec, hyprctl keyword general:layout dwindle && notify-send 'Auto-tiling disabled'"
        "$mod, O, layoutmsg, orientationnext"
        "$mod, G, togglefloating,"
        "$mod, M, fullscreen, 0"

        # Window movement (vim keys)
        "$mod ALT, H, movewindow, l"
        "$mod ALT, L, movewindow, r"
        "$mod ALT, K, movewindow, u"
        "$mod ALT, J, movewindow, d"

        # Window resizing (vim keys)
        "$mod SHIFT, H, resizeactive, -50 0"
        "$mod SHIFT, L, resizeactive, 50 0"

        # Screenshots (moved from S to Print since S is used for stacking)
        ", Print, exec, /home/trbiv/nixos-config/scripts/screenshot-utility.sh"
        "$mod, Print, exec, /home/trbiv/nixos-config/scripts/screenshot-utility.sh"

        # PopOS-style stacking (using S key)
        "$mod, S, togglegroup,"
        "$mod CTRL, H, changegroupactive, b"
        "$mod CTRL, L, changegroupactive, f"

        # Display management
        "$mod SHIFT, D, exec, nwg-displays"

        # Window border toggle
        "$mod, F1, exec, /home/trbiv/nixos-config/scripts/toggle-window-borders.sh"
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

      # Window rules for performance
      windowrulev2 = [
        "rounding 0,class:.*"  # No rounded corners for better performance
        "noshadow,class:.*"  # Ensure no shadows on any windows
        "noblur,class:.*"  # Ensure no blur on any windows
        
        # Browser-specific optimizations
        "immediate,class:^(brave-browser)$"  # Immediate rendering for Brave
        "immediate,class:^(firefox)$"  # Immediate rendering for Firefox
        "immediate,class:^(chromium-browser)$"  # Immediate rendering for Chromium
        "immediate,class:^(google-chrome)$"  # Immediate rendering for Chrome
        "nodim,class:^(brave-browser)$"  # No dimming for browsers
        "nodim,class:^(firefox)$"
        "nodim,class:^(chromium-browser)$"
        "nodim,class:^(google-chrome)$"
      ];
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        height = 24;

        modules-left = [
          "hyprland/workspaces"
          "cpu"
          "memory"
          "temperature"
          "backlight"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "bluetooth"
          "wireplumber"
          "battery"
          "tray"
          "clock"
          "custom/power"
        ];

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
          format = "{capacity}% {icon} ";
          format-alt = "{time} {icon} ";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
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
          format-icons = [
            ""
            ""
            ""
            ""
          ];
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
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = false;
        };

        backlight = {
          format = "☀ {percent}%";
          format-icons = ["☀"];
          on-scroll-up = "brightnessctl set +5%";
          on-scroll-down = "brightnessctl set 5%-";
          tooltip = false;
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

        "custom/power" = {
          format = "⏻";
          on-click = "/home/trbiv/nixos-config/scripts/power-menu.sh";
          tooltip-format = "Power Options: Lock, Logout, Shutdown";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 1px;
        font-family: "0xProto", monospace;
        font-size: 14px;
        font-weight: 500;
        box-shadow: none;
        text-shadow: none;
        transition-duration: 200ms;
      }

      window#waybar {
        color: ${currentTheme.waybar.foreground};
        background: ${currentTheme.waybar.background};
        border: 1px solid ${currentTheme.waybar.border};
        border-radius: 0px;
        margin: 2px;
      }

      /* Left modules */
      #workspaces {
        margin: 0 8px 0 4px;
        padding: 0 1px;
        background: transparent;
      }

      #workspaces button {
        padding: 0px 2px;
        margin: 0;
        color: ${currentTheme.waybar.workspace_inactive};
        border-radius: 4px;
        transition: all 200ms ease;
        background: transparent;
      }

      #workspaces button.visible {
        color: ${currentTheme.waybar.foreground};
        background: ${currentTheme.waybar.workspace_visible};
      }

      #workspaces button.focused {
        color: #ffffff;
        background: ${currentTheme.waybar.workspace_active};
        box-shadow: 0px 2px 8px ${currentTheme.waybar.workspace_active};
      }

      #workspaces button.urgent {
        color: ${currentTheme.waybar.critical};
        background: ${currentTheme.waybar.critical};
      }

      /* System info modules - left side */
      #cpu, #memory, #temperature, #backlight {
        margin: 0 3px;
        padding: 0 4px;
        background: transparent;
        min-width: 20px;
        color: ${currentTheme.waybar.foreground};
      }

      /* Center window title */
      #window {
        margin: 0 8px;
        padding: 0 6px;
        background: transparent;
        color: ${currentTheme.colors.fg};
        font-weight: 400;
      }

      /* Right modules */
      #bluetooth, #wireplumber, #battery, #tray, #clock, #custom-power {
        margin: 0 3px;
        padding: 0 4px;
        background: transparent;
        min-width: 16px;
        color: ${currentTheme.waybar.foreground};
      }

      #battery {
        min-width: 50px;
      }

      #clock {
        margin: 0 3px;
        font-weight: 600;
        min-width: 60px;
      }

      #custom-power {
        margin: 0 4px 0 3px;
        color: ${currentTheme.waybar.power_button};
        font-size: 16px;
        transition: all 200ms ease;
      }

      #custom-power:hover {
        color: ${currentTheme.waybar.power_button_hover};
        background: ${currentTheme.waybar.power_button};
        border-radius: 4px;
      }

      /* Battery states */
      #battery.warning {
        color: ${currentTheme.waybar.warning};
      }

      #battery.critical {
        color: ${currentTheme.waybar.critical};
        animation: blink 1s linear infinite alternate;
      }

      #battery.charging {
        color: ${currentTheme.waybar.charging};
      }

      #temperature.critical {
        color: ${currentTheme.waybar.critical};
        animation: blink 1s linear infinite alternate;
      }

      @keyframes blink {
        to {
          opacity: 0.5;
        }
      }
    '';
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };

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
    swayidle
    nwg-displays
  ];

  # Copy desktop entries for utilities
  xdg.dataFile."applications/wallpaper-selector.desktop".source = ../../desktop-entries/wallpaper-selector.desktop;
  xdg.dataFile."applications/toggle-window-borders.desktop".source = ../../desktop-entries/toggle-window-borders.desktop;
  xdg.dataFile."applications/toggle-waybar.desktop".source = ../../desktop-entries/toggle-waybar.desktop;
}
