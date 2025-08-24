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
        active_opacity = 0.98;
        inactive_opacity = 0.95;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(${builtins.substring 1 6 currentTheme.colors.bg1}ee)";
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

      # Dark theme - shared
      env = [
        "GTK_THEME,Adwaita:dark"
        "QT_STYLE_OVERRIDE,adwaita-dark"
      ];

      exec-once = [
        "foot --server"
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
        "$mod, T, exec, footclient"
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

        # Wallpaper switching
        "$mod, W, exec, /home/trbiv/nixos-config/scripts/wallpaper-switcher.sh next"
        "$mod SHIFT, W, exec, /home/trbiv/nixos-config/scripts/wallpaper-switcher.sh prev"

        # Toggle waybar
        "$mod, V, exec, pkill -SIGUSR1 waybar"

        # Screenshots (moved from S to Print since S is used for stacking)
        ", Print, exec, /home/trbiv/nixos-config/scripts/screenshot-utility.sh"
        "$mod, Print, exec, /home/trbiv/nixos-config/scripts/screenshot-utility.sh"

        # PopOS-style stacking (using S key)
        "$mod, S, togglegroup,"
        "$mod CTRL, H, changegroupactive, b"
        "$mod CTRL, L, changegroupactive, f"
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
          "custom/wallpaper"
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
        color: ${currentTheme.colors.fg1};
        font-weight: 400;
      }

      /* Right modules */
      #custom-wallpaper, #bluetooth, #wireplumber, #battery, #tray, #clock, #custom-power {
        margin: 0 3px;
        padding: 0 4px;
        background: transparent;
        min-width: 16px;
        color: ${currentTheme.waybar.foreground};
      }

      #custom-wallpaper {
        margin: 0 3px 0 4px;
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
  ];
}
