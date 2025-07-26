{
  inputs,
  pkgs,
  ...
}:
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
        o = {
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
          name = "gruvbox";
          style = "dark";
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
          grammars = [
            "bash" "c" "html" "lua" "luadoc" "markdown" "vim" "vimdoc" 
            "python" "nix" "typescript" "javascript" "rust" "go"
          ];
        };

        lsp = {
          enable = true;
          formatOnSave = false; # We'll use conform for formatting
        };

        languages = {
          nix.enable = true;
          ts.enable = true;
          rust.enable = true;
          python.enable = true;
          go.enable = true;
          astro.enable = true;
          c.enable = true;
          lua.enable = true;
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
              sources.default = ["lsp" "path" "snippets" "buffer"];
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
            theme = "gruvbox";
          };
        };

        globals.mapleader = " ";

        binds = {
          whichKey = {
            enable = true;
            setupOpts = {};
          };
        };

        utility = {
          yazi-nvim = {
            enable = true;
            setupOpts.open_for_directories = true;
          };
          surround.enable = true;
        };

        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true;
        };

        undoFile.enable = true;

        # Add custom LSP keybindings and Mason-like functionality via extraPlugins
        extraPlugins = with pkgs.vimPlugins; {
          # Mason for LSP server management
          mason-nvim = {
            package = mason-nvim;
            setup = ''
              require('mason').setup()
            '';
          };
          
          mason-lspconfig-nvim = {
            package = mason-lspconfig-nvim;
            setup = ''
              require('mason-lspconfig').setup({
                ensure_installed = { 'clangd', 'ruff', 'rust_analyzer', 'solidity', 'gopls', 'ts_ls', 'lua_ls' },
                handlers = {
                  function(server_name)
                    require('lspconfig')[server_name].setup({})
                  end,
                }
              })
            '';
          };

          # Conform for formatting
          conform-nvim = {
            package = conform-nvim;
            setup = ''
              require('conform').setup({
                notify_on_error = false,
                format_on_save = function(bufnr)
                  local disable_filetypes = { c = true, cpp = true }
                  return {
                    timeout_ms = 500,
                    lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                  }
                end,
                formatters_by_ft = {
                  lua = { "stylua" },
                  python = { "isort", "black" },
                  javascript = { { "prettierd", "prettier" } },
                },
              })
              
              -- Format keybinding
              vim.keymap.set('', '<leader>f', function()
                require('conform').format({ async = true, lsp_fallback = true })
              end, { desc = '[F]ormat buffer' })
            '';
          };

          # Fidget for LSP progress
          fidget-nvim = {
            package = fidget-nvim;
            setup = ''require('fidget').setup({})'';
          };

          # Neodev for Lua LSP
          neodev-nvim = {
            package = neodev-nvim;
            setup = ''require('neodev').setup({})'';
          };

          # Telescope extensions
          telescope-fzf-native-nvim = {
            package = telescope-fzf-native-nvim;
            setup = ''
              require('telescope').load_extension('fzf')
            '';
          };

          telescope-ui-select-nvim = {
            package = telescope-ui-select-nvim;
            setup = ''
              require('telescope').load_extension('ui-select')
            '';
          };
        };

        # Custom LSP and Telescope keybindings
        keymaps = [
          # LSP keybindings
          {
            key = "gd";
            mode = "n";
            action = "<cmd>Telescope lsp_definitions<cr>";
            options.desc = "[G]oto [D]efinition";
          }
          {
            key = "gr";
            mode = "n";
            action = "<cmd>Telescope lsp_references<cr>";
            options.desc = "[G]oto [R]eferences";
          }
          {
            key = "gI";
            mode = "n";
            action = "<cmd>Telescope lsp_implementations<cr>";
            options.desc = "[G]oto [I]mplementation";
          }
          {
            key = "<leader>D";
            mode = "n";
            action = "<cmd>Telescope lsp_type_definitions<cr>";
            options.desc = "Type [D]efinition";
          }
          {
            key = "<leader>ds";
            mode = "n";
            action = "<cmd>Telescope lsp_document_symbols<cr>";
            options.desc = "[D]ocument [S]ymbols";
          }
          {
            key = "<leader>ws";
            mode = "n";
            action = "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>";
            options.desc = "[W]orkspace [S]ymbols";
          }
          {
            key = "<leader>rn";
            mode = "n";
            action = "vim.lsp.buf.rename";
            options.desc = "[R]e[n]ame";
          }
          {
            key = "<leader>ca";
            mode = "n";
            action = "vim.lsp.buf.code_action";
            options.desc = "[C]ode [A]ction";
          }
          {
            key = "<leader>k";
            mode = "n";
            action = "vim.lsp.buf.hover";
            options.desc = "Hover Documentation";
          }
          {
            key = "<leader>K";
            mode = "n";
            action = "vim.diagnostic.open_float";
            options.desc = "Hover Diagnostics";
          }
          {
            key = "gD";
            mode = "n";
            action = "vim.lsp.buf.declaration";
            options.desc = "[G]oto [D]eclaration";
          }

          # Telescope keybindings
          {
            key = "<leader>sh";
            mode = "n";
            action = "<cmd>Telescope help_tags<cr>";
            options.desc = "[S]earch [H]elp";
          }
          {
            key = "<leader>sk";
            mode = "n";
            action = "<cmd>Telescope keymaps<cr>";
            options.desc = "[S]earch [K]eymaps";
          }
          {
            key = "<leader>sf";
            mode = "n";
            action = "<cmd>Telescope find_files<cr>";
            options.desc = "[S]earch [F]iles";
          }
          {
            key = "<leader>ss";
            mode = "n";
            action = "<cmd>Telescope builtin<cr>";
            options.desc = "[S]earch [S]elect Telescope";
          }
          {
            key = "<leader>sw";
            mode = "n";
            action = "<cmd>Telescope grep_string<cr>";
            options.desc = "[S]earch current [W]ord";
          }
          {
            key = "<leader>sg";
            mode = "n";
            action = "<cmd>Telescope live_grep<cr>";
            options.desc = "[S]earch by [G]rep";
          }
          {
            key = "<leader>sd";
            mode = "n";
            action = "<cmd>Telescope diagnostics<cr>";
            options.desc = "[S]earch [D]iagnostics";
          }
          {
            key = "<leader>sr";
            mode = "n";
            action = "<cmd>Telescope resume<cr>";
            options.desc = "[S]earch [R]esume";
          }
          {
            key = "<leader>s.";
            mode = "n";
            action = "<cmd>Telescope oldfiles<cr>";
            options.desc = "[S]earch Recent Files";
          }
          {
            key = "<leader><leader>";
            mode = "n";
            action = "<cmd>Telescope buffers<cr>";
            options.desc = "[ ] Find existing buffers";
          }
          {
            key = "<leader>sn";
            mode = "n";
            action = "<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })<cr>";
            options.desc = "[S]earch [N]eovim files";
          }
        ];

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
