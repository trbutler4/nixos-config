{
  config,
  pkgs,
  ...
}:

{
  # Yoga-specific Hyprland overrides
  wayland.windowManager.hyprland.settings = {
    # Touchpad configuration - disable natural scrolling
    input = {
      touchpad = {
        natural_scroll = false;
      };
    };
  };

  # Yoga-specific Hyprpaper wallpaper configuration
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      
      preload = [
        "~/Pictures/wallpapers/zen-arch.jpg"
      ];
      
      wallpaper = [
        ",~/Pictures/wallpapers/zen-arch.jpg"
      ];
    };
  };
}
