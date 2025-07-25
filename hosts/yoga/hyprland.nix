{
  config,
  pkgs,
  ...
}:

{
  # Yoga-specific Hyprland overrides
  wayland.windowManager.hyprland.settings = {
    # Monitor configuration - yoga specific (laptop display)
    monitor = ",preferred,auto,auto";
  };

  # Yoga-specific Hyprpaper wallpaper configuration
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