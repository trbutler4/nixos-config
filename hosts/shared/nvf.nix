{
  inputs,
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

        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
          transparent = true;
        };

        treesitter = {
          enable = true;
          fold = true;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
        };

        languages = {
          nix.enable = true;
          ts.enable = true;
          rust.enable = true;
          python.enable = true;
          go.enable = true;
          astro.enable = true;
        };

        autocomplete = {
          nvim-cmp.enable = true;
        };

        filetree = {
          nvimTree = {
            enable = true;
            mappings = {
              toggle = "<leader>e";
            };
          };
        };

        telescope = {
          enable = true;
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
          };
        };

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
