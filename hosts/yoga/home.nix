{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../shared/base-home.nix
    ../shared/base-hyprland.nix
    ./hyprland.nix
  ];

  home.username = "trbiv";
  home.homeDirectory = "/home/trbiv";
  home.stateVersion = "25.05";

  # Alacritty transparency override for yoga
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.95;
      };
    };
  };
}
