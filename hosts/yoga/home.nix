{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../shared/base-home-themed.nix
    ../shared/base-hyprland-themed.nix
    #../shared/nvf-themed.nix
    ./hyprland.nix
  ];

  home.username = "trbiv";
  home.homeDirectory = "/home/trbiv";
  home.stateVersion = "25.05";
}
