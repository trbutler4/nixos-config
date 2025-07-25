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
}
