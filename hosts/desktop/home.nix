{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../shared/base-home.nix
    ../shared/base-hyprland.nix
    ../shared/nvf.nix
    ./hyprland.nix
  ];

  home.username = "trbiv";
  home.homeDirectory = "/home/trbiv";
  home.stateVersion = "25.05";

  home.file."Pictures/Wallpapers".source = ../../assets/wallpapers;
}
