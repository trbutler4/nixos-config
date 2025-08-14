{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../shared/base-hyprland.nix
    #../shared/nvf.nix
    ./hyprland.nix
  ];

  home.username = "guest";
  home.homeDirectory = "/home/guest";
  home.stateVersion = "25.05";
  home.enableNixpkgsReleaseCheck = false;

  # Minimal guest configuration - basic programs without personal SSH scripts
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "lambda";
    };
    shellAliases = {
      lg = "lazygit";
      z = "zellij";
      y = "yazi";
      nv = "nvim";
    };
    initContent = ''
      export EDITOR=nvim
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim.enable = true;
  programs.firefox.enable = true;
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "None";
        opacity = 0.95;
      };
      colors.transparent_background_colors = true;
    };
  };

  # Essential packages for guest user
  home.packages = with pkgs; [
    # Essential tools
    git
    htop
    vim
    firefox
    alacritty
    
    # Terminal utilities
    fzf
    yazi
    lazygit
    unzip
    wl-clipboard
    ripgrep
    jq
  ];

  # Cursor theme configuration
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Vanilla-DMZ";
    XCURSOR_SIZE = "24";
  };
}
