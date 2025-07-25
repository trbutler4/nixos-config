{
  config,
  pkgs,
  ...
}:

{
  # Desktop-specific Hyprland overrides
  wayland.windowManager.hyprland.settings = {
    # Monitor configuration - desktop specific (multiple monitors, higher res, etc.)
    monitor = [
      ",preferred,auto,auto"
      # Add specific monitor configs here when you set up desktop
      # Example: "DP-1,1920x1080@60,0x0,1"
      # Example: "HDMI-1,1920x1080@60,1920x0,1"
    ];
  };

  # Desktop-specific Hyprpaper wallpaper configuration
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
}