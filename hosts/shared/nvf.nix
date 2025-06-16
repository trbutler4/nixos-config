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

        telescope.enable = true;

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
            setupOpts.preset = "helix";
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

        extrapackages = [
          pkgs.ripgrep
        ];

      };
    };
  };
}
