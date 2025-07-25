{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../shared/base-home.nix
    ../shared/hyprland-base.nix
    ./hyprland.nix
  ];
}