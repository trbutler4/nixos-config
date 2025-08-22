{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];
  programs.nixvim = {
    enable = true;

    # Basic vim options
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 2;
      expandtab = true;
      autoread = true;
      swapfile = false;
      termguicolors = true;
      background = "dark";
    };

    globals.mapleader = " ";

    # Theme
    colorschemes.gruvbox = {
      enable = true;
      settings = {
        transparent_mode = true;
      };
    };

    # Clipboard
    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };

    # Plugins
    plugins = {
      # Autopairs
      nvim-autopairs.enable = true;

      # Treesitter
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          c
          html
          lua
          luadoc
          markdown
          vim
          vimdoc
          python
          nix
          typescript
          javascript
          rust
          go
        ];
      };

      # LSP
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;  # Nix
          ts_ls.enable = true;   # TypeScript
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          pyright.enable = true; # Python
          gopls.enable = true;   # Go
          astro.enable = true;   # Astro
          lua_ls.enable = true;  # Lua
        };
      };

      # Completion
      blink-cmp = {
        enable = true;
        settings = {
          keymap.preset = "default";
          appearance.nerd_font_variant = "mono";
          completion.documentation.auto_show = false;
          sources.default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
          fuzzy.implementation = "prefer_rust_with_warning";
        };
      };

      # Telescope
      telescope = {
        enable = true;
        extensions = {
          ui-select.enable = true;
        };
      };

      # Git
      gitsigns.enable = true;

      # Status line
      lualine = {
        enable = true;
        settings.options.theme = "gruvbox";
      };

      # Which-key
      which-key.enable = true;

      # Web devicons (explicitly enable to avoid warnings)
      web-devicons.enable = true;

      # File manager
      yazi = {
        enable = true;
        settings.open_for_directories = true;
      };

      # Surround
      nvim-surround.enable = true;

      # Terminal
      toggleterm = {
        enable = true;
        settings = {
          open_mapping = "[[<c-\\>]]";
        };
      };

      # Lazygit
      lazygit.enable = true;
    };

    # Enable undo file
    extraConfigLua = ''
      vim.opt.undofile = true
    '';

    # Extra packages
    extraPackages = with pkgs; [
      ripgrep
      stylua
      black
      isort
      prettierd
    ];
  };
}