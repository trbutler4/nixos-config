{ config, pkgs, lib, ... }:

let
  # Theme configuration
  themes = import ./themes/default.nix;
  currentTheme = themes.${themes.current};
in
{
  programs.neovim = {
    enable = true;
    viAlias = false;
    vimAlias = true;
    
    # Install language servers and tools
    extraPackages = with pkgs; [
      # Language servers
      lua-language-server
      nil # Nix LSP
      nodePackages.typescript-language-server
      rust-analyzer
      gopls
      ruff
      clang-tools
      solc
      
      # Formatters
      stylua
      black
      isort
      prettierd
      prettier
      
      # Tools
      ripgrep
      fd
      gnumake
      gcc
    ];

    plugins = with pkgs.vimPlugins; [
      # Completion
      {
        plugin = blink-cmp;
        config = ''
          lua << END
          require('blink.cmp').setup({
            keymap = { preset = "default" },
            appearance = {
              nerd_font_variant = "mono",
            },
            completion = { documentation = { auto_show = false } },
            sources = {
              default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
          })
          END
        '';
      }
      friendly-snippets

      # Formatting
      {
        plugin = conform-nvim;
        config = ''
          lua << END
          require("conform").setup({
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
          vim.keymap.set("", "<leader>f", function()
            require("conform").format({ async = true, lsp_fallback = true })
          end, { desc = "[F]ormat buffer" })
          END
        '';
      }

      # Autopairs
      {
        plugin = nvim-autopairs;
        config = ''
          lua require('nvim-autopairs').setup({})
        '';
      }

      # Theme plugins
      {
        plugin = gruvbox-nvim;
        config = ''
          lua << END
          require("gruvbox").setup({
            transparent_mode = true,
          })
          END
        '';
      }

      everforest

      # Git
      {
        plugin = gitsigns-nvim;
        config = ''
          lua << END
          require('gitsigns').setup({
            signs = {
              add = { text = "+" },
              change = { text = "~" },
              delete = { text = "_" },
              topdelete = { text = "‾" },
              changedelete = { text = "~" },
            },
          })
          END
        '';
      }


      # LSP Configuration
      {
        plugin = nvim-lspconfig;
        config = ''
          lua << END
          -- LSP keymaps
          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
              local map = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
              end

              map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
              map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
              map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
              map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
              map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
              map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
              map("<leader>k", vim.lsp.buf.hover, "Hover Documentation")
              map("<leader>K", vim.diagnostic.open_float, "Hover Diagnostics")
              map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

              -- Highlight references
              local client = vim.lsp.get_client_by_id(event.data.client_id)
              if client and client.server_capabilities.documentHighlightProvider then
                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                  buffer = event.buf,
                  callback = vim.lsp.buf.document_highlight,
                })
                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                  buffer = event.buf,
                  callback = vim.lsp.buf.clear_references,
                })
              end
            end,
          })

          -- Setup capabilities with blink.cmp
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))

          -- Setup LSP servers
          local lspconfig = require('lspconfig')
          
          -- Lua
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
          
          -- TypeScript
          lspconfig.ts_ls.setup({ capabilities = capabilities })
          
          -- Rust
          lspconfig.rust_analyzer.setup({ capabilities = capabilities })
          
          -- Go
          lspconfig.gopls.setup({ capabilities = capabilities })
          
          -- Python
          lspconfig.ruff.setup({ capabilities = capabilities })
          
          -- C/C++
          lspconfig.clangd.setup({ capabilities = capabilities })
          
          -- Nix
          lspconfig.nil_ls.setup({ capabilities = capabilities })
          
          -- Solidity
          lspconfig.solidity.setup({ capabilities = capabilities })
          END
        '';
      }
      fidget-nvim
      neodev-nvim

      # Statusline
      {
        plugin = lualine-nvim;
        config = ''
          lua << END
          require("lualine").setup({
            options = {
              theme = "${if currentTheme.name == "gruvbox" then "gruvbox" else "everforest"}",
            },
          })
          END
        '';
      }
      nvim-web-devicons

      # Miscellaneous
      vim-sleuth
      {
        plugin = comment-nvim;
        config = ''
          lua require('Comment').setup({})
        '';
      }
      {
        plugin = todo-comments-nvim;
        config = ''
          lua require('todo-comments').setup({ signs = false })
        '';
      }

      # Telescope
      {
        plugin = telescope-nvim;
        config = ''
          lua << END
          require("telescope").setup({
            extensions = {
              ["ui-select"] = {
                require("telescope.themes").get_dropdown(),
              },
            },
          })
          
          -- Load extensions
          pcall(require("telescope").load_extension, "fzf")
          pcall(require("telescope").load_extension, "ui-select")
          
          -- Keymaps
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
          vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
          vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
          vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
          vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
          vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
          vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
          vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
          vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
          vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
          
          -- LSP mappings for Telescope
          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
            callback = function(event)
              local map = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
              end
              
              map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
              map("gr", builtin.lsp_references, "[G]oto [R]eferences")
              map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
              map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
              map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
              map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
            end,
          })
          
          -- Advanced search keymaps
          vim.keymap.set("n", "<leader>/", function()
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
              winblend = 10,
              previewer = false,
            }))
          end, { desc = "[/] Fuzzily search in current buffer" })
          
          vim.keymap.set("n", "<leader>s/", function()
            builtin.live_grep({
              grep_open_files = true,
              prompt_title = "Live Grep in Open Files",
            })
          end, { desc = "[S]earch [/] in Open Files" })
          
          vim.keymap.set("n", "<leader>sn", function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
          end, { desc = "[S]earch [N]eovim files" })
          END
        '';
      }
      telescope-fzf-native-nvim
      telescope-ui-select-nvim

      # Treesitter
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = ''
          lua << END
          require("nvim-treesitter.configs").setup({
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = { "ruby" },
            },
            indent = { enable = true, disable = { "ruby" } },
          })
          END
        '';
      }

      # Which-key
      {
        plugin = which-key-nvim;
        config = ''
          lua << END
          require("which-key").setup({})
          vim.keymap.set("n", "<leader>?", function()
            require("which-key").show({ global = false })
          end, { desc = "Buffer Local Keymaps (which-key)" })
          END
        '';
      }

      # Oil file manager
      {
        plugin = oil-nvim;
        config = ''
          lua << END
          require("oil").setup({
            default_file_explorer = true,
            view_options = {
              show_hidden = false,
              is_hidden_file = function(name, bufnr)
                return vim.startswith(name, ".")
              end,
              is_always_hidden = function(name, bufnr)
                return false
              end,
            },
            float = {
              padding = 2,
              max_width = 0,
              max_height = 0,
              border = "rounded",
              win_options = {
                winblend = 0,
              },
            },
            keymaps = {
              ["g?"] = "actions.show_help",
              ["<CR>"] = "actions.select",
              ["<C-s>"] = "actions.select_vsplit",
              ["<C-h>"] = "actions.select_split",
              ["<C-t>"] = "actions.select_tab",
              ["<C-p>"] = "actions.preview",
              ["<C-c>"] = "actions.close",
              ["<C-l>"] = "actions.refresh",
              ["-"] = "actions.parent",
              ["_"] = "actions.open_cwd",
              ["`"] = "actions.cd",
              ["~"] = "actions.tcd",
              ["gs"] = "actions.change_sort",
              ["gx"] = "actions.open_external",
              ["g."] = "actions.toggle_hidden",
              ["g\\"] = "actions.toggle_trash",
            },
          })
          
          vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
          vim.keymap.set("n", "<leader>-", "<CMD>Oil --float<CR>", { desc = "Open parent directory in floating window" })
          END
        '';
      }

    ];

    # Extra configuration (init.lua content)
    extraLuaConfig = ''
      -- Set tabs to always be 4 spaces
      vim.o.tabstop = 4
      vim.o.softtabstop = 4
      vim.o.shiftwidth = 2
      vim.o.expandtab = true

      -- Disable netrw
      vim.g.disable_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      -- Leader key is space
      vim.g.mapleader = " "

      -- Basic settings
      vim.cmd([[
        set number
        set clipboard+=unnamedplus
        set autoread
        set noswapfile
      ]])

      -- Set colorscheme based on current theme
      vim.o.background = "dark"
      vim.cmd([[colorscheme ${currentTheme.neovim.colorscheme}]])
    '';
  };
}
