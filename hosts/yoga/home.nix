{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ../shared/home.nix
  ];

  # Yoga-specific user configurations can go here
  # For example, laptop-specific packages or settings
  home.packages = with pkgs; [
    # GNOME stuff
    gnome-themes-extra
    gnome-tweaks
    adwaita-icon-theme
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/shell" = {
        disable-user-extensions = false; # enables user extensions
        enabled-extensions = [
          # Put UUIDs of extensions that you want to enable here.
          # If the extension you want to enable is packaged in nixpkgs,
          # you can easily get its UUID by accessing its extensionUuid
          # field (look at the following example).
          pkgs.gnomeExtensions.tiling-shell.extensionUuid
          pkgs.gnomeExtensions.hide-top-bar.extensionUuid
          pkgs.gnomeExtensions.appindicator.extensionUuid
          pkgs.gnomeExtensions.desktop-clock.extensionUuid
        ];
      };
    };
  };

}
