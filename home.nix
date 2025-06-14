{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  # Basic home manager config
  home.username = "trbiv";
  home.homeDirectory = "/home/trbiv";
  home.stateVersion = "25.05";

  # Packages
  home.packages = with pkgs; [
    atool
    httpie
  ];

  # Firefox
  programs.firefox.enable = true;

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "lambda";
    };
  };

  # Fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Basic nvf configuration
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

        # Basic options
        lineNumberMode = "number";
        preventJunkFiles = true;

        # Theme
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

        # Treesitter for syntax highlighting
        treesitter = {
          enable = true;
          fold = true;
        };

        # LSP Configuration
        lsp = {
          enable = true;
          formatOnSave = true;
        };

        # Language support
        languages = {
          nix.enable = true;

          ts = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };

          rust = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };

          python = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };

          go = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
        };

        # Autocompletion
        autocomplete = {
          nvim-cmp.enable = true;
        };

        # File tree
        filetree = {
          nvimTree = {
            enable = true;
            mappings = {
              toggle = "<leader>e";
            };
          };
        };

        # Telescope for fuzzy finding
        telescope = {
          enable = true;
        };

        # Git integration
        git = {
          enable = true;
          gitsigns.enable = true;
        };

        # Status line
        statusline = {
          lualine = {
            enable = true;
            theme = "gruvbox";
          };
        };

        # Leader key
        globals.mapleader = " ";
      };
    };
  };
}
