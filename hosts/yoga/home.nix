{
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
}
