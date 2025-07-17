# NixOS Configuration with nvf

This repository contains my NixOS configuration with Home Manager and nvf (Neovim flake) integration.

## Overview

- **OS**: NixOS with flakes enabled
- **Desktop**: GNOME with GDM
- **Editor**: Neovim configured via nvf
- **Shell**: Zsh with Oh My Zsh
- **Package Management**: Nix flakes

## Structure

```
nixos-config/
├── flake.nix                 # Main flake configuration
├── flake.lock               # Flake lockfile
├── home.nix                 # Home Manager configuration with nvf
├── hosts/                   # Host-specific configurations
│   ├── desktop/             # Desktop host configuration
│   │   └── configuration.nix
│   └── yoga/                # Yoga host configuration
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── update.sh               # Update script for flake-based rebuilds
└── README.md               # This file
```

## nvf Configuration

The Neovim configuration includes:

### Features
- **Theme**: Catppuccin Mocha
- **LSP Support**: Nix, TypeScript, Rust, Python, Go
- **Syntax Highlighting**: Treesitter
- **File Explorer**: nvim-tree (`<leader>e` to toggle)
- **Fuzzy Finder**: Telescope
- **Git Integration**: gitsigns
- **Status Line**: Lualine
- **Autocompletion**: nvim-cmp
- **Line Numbers**: Relative line numbers enabled

### Key Mappings
- Leader key: `<space>`
- File tree toggle: `<leader>e`
- All other mappings use nvf defaults

### Language Support
- **Nix**: LSP + Treesitter
- **TypeScript/JavaScript**: LSP + Treesitter  
- **Rust**: LSP + Treesitter
- **Python**: LSP + Treesitter
- **Go**: LSP + Treesitter

## Usage

### Initial Setup

1. Clone this repository to your desired location
2. Run the update script to apply the configuration:
   ```bash
   bash update.sh <host>
   ```

### Making Changes

1. Edit the relevant configuration files:
   - `hosts/<hostname>/configuration.nix` for host-specific system-level changes
   - `home.nix` for user-level and nvf changes
   - `flake.nix` for input updates or structural changes

2. Apply changes:
   ```bash
   sudo nixos-rebuild switch --flake .#${HOSTNAME}
   ```


## Customizing nvf

To customize Neovim further, edit `home.nix` and modify the `programs.nvf.settings.vim` section. 

### Adding Languages

To add support for a new language, add it to the `languages` section:

```nix
languages = {
  # existing languages...
  
  java = {
    enable = true;
    lsp.enable = true;
    treesitter.enable = true;
  };
};
```

### Adding Plugins

nvf provides many built-in plugins. Check the [nvf documentation](https://notashelf.github.io/nvf/) for available options.

### Custom Keymaps

Add custom keymaps in the nvf configuration:

```nix
vim = {
  # existing config...
  
  keymaps = [
    {
      mode = "n";
      key = "<leader>w";
      action = "<cmd>w<cr>";
      desc = "Save file";
    }
  ];
};
```

## Troubleshooting

### Build Errors

If you encounter build errors:

1. Check that all files are committed to git (flakes require this)
2. Run `nix flake check` to validate the configuration
3. Check the error messages for specific issues

### nvf Issues

- Consult the [nvf documentation](https://notashelf.github.io/nvf/)
- Check available options: `nix flake show github:notashelf/nvf`
- Look at the [nvf examples](https://github.com/notashelf/nvf/tree/main/examples)

### Reverting Changes

If something breaks, you can rollback:
```bash
sudo nixos-rebuild switch --rollback
```

## Resources

- [nvf Documentation](https://notashelf.github.io/nvf/)
- [nvf GitHub Repository](https://github.com/notashelf/nvf)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
