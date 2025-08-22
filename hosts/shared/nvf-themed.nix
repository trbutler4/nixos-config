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
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        lineNumberMode = "relative";
        preventJunkFiles = true;

        # Custom vim options to match current config
        options = {
          tabstop = 4;
          softtabstop = 4;
          shiftwidth = 2;
          expandtab = true;
          number = true;
          autoread = true;
          swapfile = false;
          termguicolors = true;
          background = "dark";
        };

        theme = {
          enable = true;
          name = currentTheme.nvf.name;
          style = "medium";
          transparent = true;
        };

        clipboard = {
          enable = true;
          providers.xclip.enable = true;
        };

        autopairs = {
          nvim-autopairs.enable = true;
        };

        treesitter = {
          enable = true;
          fold = true;
          grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
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

        lsp = {
          enable = true;
        };

        languages = {
          nix.enable = true;
          ts.enable = true;
          rust.enable = true;
          python.enable = true;
          go.enable = true;
          astro.enable = true;
          lua.enable = true;
          clang.enable = true;
        };

        # Use blink.cmp instead of nvim-cmp
        autocomplete = {
          nvim-cmp.enable = false;
          blink-cmp = {
            enable = true;
            setupOpts = {
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
        };

        telescope = {
          enable = true;
          setupOpts = {
            extensions = {
              "ui-select" = {
                # Use dropdown theme for ui-select
              };
            };
          };
        };

        git = {
          enable = true;
          gitsigns.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = currentTheme.nvf.name;
          };
        };

        globals.mapleader = " ";

        binds = {
          whichKey = {
            enable = true;
            setupOpts = { };
          };
        };

        keymaps = [
          # Telescope keybindings
          {
            mode = "n";
            key = "<leader>sh";
            action = "<cmd>Telescope help_tags<CR>";
            desc = "[S]earch [H]elp";
          }
          {
            mode = "n";
            key = "<leader>sk";
            action = "<cmd>Telescope keymaps<CR>";
            desc = "[S]earch [K]eymaps";
          }
          {
            mode = "n";
            key = "<leader>sf";
            action = "<cmd>Telescope find_files<CR>";
            desc = "[S]earch [F]iles";
          }
          {
            mode = "n";
            key = "<leader>ss";
            action = "<cmd>Telescope builtin<CR>";
            desc = "[S]earch [S]elect Telescope";
          }
          {
            mode = "n";
            key = "<leader>sw";
            action = "<cmd>Telescope grep_string<CR>";
            desc = "[S]earch current [W]ord";
          }
          {
            mode = "n";
            key = "<leader>sg";
            action = "<cmd>Telescope live_grep<CR>";
            desc = "[S]earch by [G]rep";
          }
          {
            mode = "n";
            key = "<leader>sd";
            action = "<cmd>Telescope diagnostics<CR>";
            desc = "[S]earch [D]iagnostics";
          }
          {
            mode = "n";
            key = "<leader>sr";
            action = "<cmd>Telescope resume<CR>";
            desc = "[S]earch [R]esume";
          }
          {
            mode = "n";
            key = "<leader>s.";
            action = "<cmd>Telescope oldfiles<CR>";
            desc = "[S]earch Recent Files";
          }
          {
            mode = "n";
            key = "<leader><leader>";
            action = "<cmd>Telescope buffers<CR>";
            desc = "[ ] Find existing buffers";
          }
          {
            mode = "n";
            key = "<leader>sn";
            action = "<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })<CR>";
            desc = "[S]earch [N]eovim files";
          }
        ];

        utility = {
          surround.enable = true;
        };

        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true;
        };

        undoFile.enable = true;

        extraPackages = [
          pkgs.ripgrep
          pkgs.stylua
          pkgs.black
          pkgs.isort
          pkgs.prettierd
        ];


      };
    };
  };
}