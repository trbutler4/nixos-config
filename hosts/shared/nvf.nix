{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    #inputs.nvf.homeManagerModules.default
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
            theme = "gruvbox";
          };
        };

        globals.mapleader = " ";

        binds = {
          whichKey = {
            enable = true;
            setupOpts = { };
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
