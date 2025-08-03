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

  home.username = "guest";
  home.homeDirectory = "/home/guest";
  home.stateVersion = "25.05";
}