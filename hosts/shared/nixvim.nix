{
  inputs,
  pkgs,
  ...
}:
let
  themes = import ./themes/default.nix;
  currentTheme = themes.${themes.current};
in
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

    # Theme - dynamically enable based on current theme
    colorschemes.gruvbox = {
      enable = currentTheme.name == "gruvbox";
      settings = {
        transparent_mode = true;
      };
    };
    
    colorschemes.everforest = {
      enable = currentTheme.name == "everforest";
      settings = {
        transparent_mode = 1;
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
          keymap = {
            preset = "default";
            "<S-Tab>" = [ "select_and_accept" ];
          };
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
        settings.options.theme = currentTheme.neovim.colorscheme;
      };

      # Which-key
      which-key.enable = true;

      # Web devicons (explicitly enable to avoid warnings)
      web-devicons.enable = true;

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

      # Oil file manager
      oil = {
        enable = true;
        settings = {
          default_file_explorer = true;
          columns = [
            "icon"
            "permissions"
            "size"
            "mtime"
          ];
          delete_to_trash = true;
          skip_confirm_for_simple_edits = true;
          view_options = {
            show_hidden = false;
            sort = [
              ["type" "asc"]
              ["name" "asc"]
            ];
          };
          float = {
            padding = 2;
            max_width = 0;
            max_height = 0;
            border = "rounded";
            win_options = {
              winblend = 0;
            };
          };
          preview = {
            max_width = 0.9;
            min_width = [ 40 0.4 ];
            max_height = 0.9;
            min_height = [ 5 0.1 ];
            border = "rounded";
            win_options = {
              winblend = 0;
            };
          };
        };
      };
    };

    # Enable undo file
    extraConfigLua = ''
      vim.opt.undofile = true
    '';

    # Keymaps
    keymaps = [
      # Oil file manager
      {
        mode = [ "n" "v" ];
        key = "<leader>-";
        action = "<cmd>Oil<cr>";
        options = {
          desc = "Open oil at the current file";
        };
      }
      {
        mode = "n";
        key = "<leader>cw";
        action = "<cmd>Oil .<cr>";
        options = {
          desc = "Open oil in nvim's working directory";
        };
      }
      {
        mode = "n";
        key = "<c-up>";
        action = "<cmd>Oil<cr>";
        options = {
          desc = "Open oil file manager";
        };
      }

      # Telescope
      {
        mode = "n";
        key = "<leader>sh";
        action = "<cmd>Telescope help_tags<cr>";
        options = {
          desc = "[S]earch [H]elp";
        };
      }
      {
        mode = "n";
        key = "<leader>sk";
        action = "<cmd>Telescope keymaps<cr>";
        options = {
          desc = "[S]earch [K]eymaps";
        };
      }
      {
        mode = "n";
        key = "<leader>sf";
        action = "<cmd>Telescope find_files<cr>";
        options = {
          desc = "[S]earch [F]iles";
        };
      }
      {
        mode = "n";
        key = "<leader>ss";
        action = "<cmd>Telescope builtin<cr>";
        options = {
          desc = "[S]earch [S]elect Telescope";
        };
      }
      {
        mode = "n";
        key = "<leader>sw";
        action = "<cmd>Telescope grep_string<cr>";
        options = {
          desc = "[S]earch current [W]ord";
        };
      }
      {
        mode = "n";
        key = "<leader>sg";
        action = "<cmd>Telescope live_grep<cr>";
        options = {
          desc = "[S]earch by [G]rep";
        };
      }
      {
        mode = "n";
        key = "<leader>sd";
        action = "<cmd>Telescope diagnostics<cr>";
        options = {
          desc = "[S]earch [D]iagnostics";
        };
      }
      {
        mode = "n";
        key = "<leader>sr";
        action = "<cmd>Telescope resume<cr>";
        options = {
          desc = "[S]earch [R]esume";
        };
      }
      {
        mode = "n";
        key = "<leader>s.";
        action = "<cmd>Telescope oldfiles<cr>";
        options = {
          desc = "[S]earch Recent Files";
        };
      }
      {
        mode = "n";
        key = "<leader><leader>";
        action = "<cmd>Telescope buffers<cr>";
        options = {
          desc = "Find existing buffers";
        };
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
        options = {
          desc = "Fuzzily search in current buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>s/";
        action = "<cmd>Telescope live_grep grep_open_files=true<cr>";
        options = {
          desc = "Search in Open Files";
        };
      }
      {
        mode = "n";
        key = "<leader>sn";
        action = "<cmd>Telescope find_files cwd=~/.config/nvim<cr>";
        options = {
          desc = "Search Neovim files";
        };
      }
      {
        mode = "n";
        key = "<leader>sc";
        action = "<cmd>Telescope git_status<cr>";
        options = {
          desc = "[S]earch [C]hanged files";
        };
      }

      # LSP
      {
        mode = "n";
        key = "gd";
        action = "<cmd>Telescope lsp_definitions<cr>";
        options = {
          desc = "[G]oto [D]efinition";
        };
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>Telescope lsp_references<cr>";
        options = {
          desc = "[G]oto [R]eferences";
        };
      }
      {
        mode = "n";
        key = "gI";
        action = "<cmd>Telescope lsp_implementations<cr>";
        options = {
          desc = "[G]oto [I]mplementation";
        };
      }
      {
        mode = "n";
        key = "<leader>D";
        action = "<cmd>Telescope lsp_type_definitions<cr>";
        options = {
          desc = "Type [D]efinition";
        };
      }
      {
        mode = "n";
        key = "<leader>ds";
        action = "<cmd>Telescope lsp_document_symbols<cr>";
        options = {
          desc = "[D]ocument [S]ymbols";
        };
      }
      {
        mode = "n";
        key = "<leader>ws";
        action = "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>";
        options = {
          desc = "[W]orkspace [S]ymbols";
        };
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "vim.lsp.buf.rename";
        lua = true;
        options = {
          desc = "[R]e[n]ame";
        };
      }
      {
        mode = [ "n" "v" ];
        key = "<leader>ca";
        action = "vim.lsp.buf.code_action";
        lua = true;
        options = {
          desc = "[C]ode [A]ction";
        };
      }
      {
        mode = "n";
        key = "<leader>k";
        action = "vim.lsp.buf.hover";
        lua = true;
        options = {
          desc = "Hover Documentation";
        };
      }
      {
        mode = "n";
        key = "<leader>K";
        action = "vim.diagnostic.open_float";
        lua = true;
        options = {
          desc = "Hover Diagnostics";
        };
      }
      {
        mode = "n";
        key = "gD";
        action = "vim.lsp.buf.declaration";
        lua = true;
        options = {
          desc = "[G]oto [D]eclaration";
        };
      }

      # Which-key
      {
        mode = "n";
        key = "<leader>?";
        action = "<cmd>WhichKey<cr>";
        options = {
          desc = "Buffer Local Keymaps (which-key)";
        };
      }
    ];

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
