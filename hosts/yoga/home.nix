{
  pkgs,
  ...
}:

{
  imports = [
    ../shared/nvf.nix
  ];

  home.username = "trbiv";
  home.homeDirectory = "/home/trbiv";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # essential
    gcc
    vim
    git
    htop
    tmux

    # GNOME stuff
    gnome-themes-extra
    gnome-tweaks
    adwaita-icon-theme

    # Nix stuff
    home-manager

    # Terminal Programs
    htop
    helix
    tmux
    zellij
    lazygit
    lazydocker
    yazi
    fastfetch
    unzip
    fzf
    gnumake
    claude-code
    asdf-vm

    # GUI Apps
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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "asdf"
      ];
      theme = "lambda";
    };
    initContent = ''
      export PATH="$HOME/.asdf/shims:$PATH"
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

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
