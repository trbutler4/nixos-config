{
  config,
  pkgs,
  inputs,
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

    # Apps
    brave
    zed-editor
    obs-studio
    spotify
    telegram-desktop
    alacritty
    ghostty
    libreoffice-still
    gimp3
    discord
    gedit

    # Tools
    claude-code
    asdf-vm

    # Node/Typescript
    nodejs_24
    bun
    yarn
    pnpm
    typescript
    typescript-language-server
    vscode-langservers-extracted
    # Python
    python3
    uv
    # Go
    go
    gopls
    golangci-lint
    golangci-lint-langserver
    # Rust
    rustup
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
