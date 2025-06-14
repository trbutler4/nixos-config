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
        lineNumberMode = "relative";
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

          astro = {
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

        # Which-key for keybinding help
        binds = {
          whichKey = {
            enable = true;
          };
        };

        # Custom keybindings
        keymaps = [
          # LSP keybindings
          {
            mode = "n";
            key = "gd";
            action = "<cmd>lua vim.lsp.buf.definition()<CR>";
            desc = "Go to definition";
          }
          {
            mode = "n";
            key = "gD";
            action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
            desc = "Go to declaration";
          }
          {
            mode = "n";
            key = "gr";
            action = "<cmd>lua vim.lsp.buf.references()<CR>";
            desc = "Go to references";
          }
          {
            mode = "n";
            key = "gi";
            action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
            desc = "Go to implementation";
          }
          {
            mode = "n";
            key = "K";
            action = "<cmd>lua vim.lsp.buf.hover()<CR>";
            desc = "Show hover information";
          }
          {
            mode = "n";
            key = "<C-k>";
            action = "<cmd>lua vim.lsp.buf.signature_help()<CR>";
            desc = "Show signature help";
          }
          {
            mode = "n";
            key = "<leader>rn";
            action = "<cmd>lua vim.lsp.buf.rename()<CR>";
            desc = "Rename symbol";
          }
          {
            mode = "n";
            key = "<leader>ca";
            action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
            desc = "Code actions";
          }
          {
            mode = "n";
            key = "[d";
            action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
            desc = "Go to previous diagnostic";
          }
          {
            mode = "n";
            key = "]d";
            action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
            desc = "Go to next diagnostic";
          }
          {
            mode = "n";
            key = "<leader>d";
            action = "<cmd>lua vim.diagnostic.open_float()<CR>";
            desc = "Show diagnostic in float";
          }
        ];
      };
    };
  };
}
