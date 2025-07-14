# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## NixOS Configuration Overview

This is a NixOS configuration repository using flakes with Home Manager integration. The configuration includes:

- **System**: NixOS with flakes enabled
- **Desktop Environment**: GNOME with GDM
- **Shell**: Zsh with Oh My Zsh (lambda theme)
- **Editor**: Neovim configured via nvf (Neovim flake)
- **Package Management**: Nix flakes with Home Manager for user packages

## Common Commands

### System Updates and Rebuilds
```bash
# Update system configuration (required hostname argument)
bash update.sh yoga

# Manual rebuild without update script
sudo nixos-rebuild switch --flake .#yoga

# Update flake inputs only
nix flake update

# Check flake configuration
nix flake check

# Show available systems
nix flake show
```

### Development Environment
```bash
# Enter development shell with specific packages
nix shell nixpkgs#package-name

# Run applications without installing
nix run nixpkgs#package-name

# Check what's available in nvf
nix flake show github:notashelf/nvf
```

### Rollback and Recovery
```bash
# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# List generations
nix-env --list-generations --profile /nix/var/nix/profiles/system
```

## Architecture

### Repository Structure
```
nixos-config/
├── flake.nix                     # Main flake configuration with inputs/outputs
├── flake.lock                    # Pinned versions of all inputs
├── update.sh                     # System update script
└── hosts/
    ├── shared/
    │   └── nvf.nix               # Shared nvf (Neovim) configuration
    └── yoga/                     # Host-specific configuration
        ├── configuration.nix     # System-level NixOS configuration
        ├── hardware-configuration.nix # Hardware-specific settings
        └── home.nix             # Home Manager user configuration
```

### Key Components

**Flake Configuration (`flake.nix`)**: Defines inputs (nixpkgs, home-manager, nvf, nix-ld) and outputs (nixosConfigurations, homeConfigurations). The yoga configuration integrates Home Manager directly into the NixOS system.

**System Configuration (`hosts/yoga/configuration.nix`)**: NixOS system settings including bootloader, networking, services (X11, GDM, GNOME), user accounts, and system packages. Enables Docker and VirtualBox virtualization.

**User Configuration (`hosts/yoga/home.nix`)**: Home Manager configuration with user packages, shell configuration (zsh + oh-my-zsh), and application settings. Includes development tools for multiple languages.

**nvf Configuration (`hosts/shared/nvf.nix`)**: Neovim configuration using the nvf flake with language support for Nix, TypeScript, Rust, Python, Go, and Astro. Features include LSP, Treesitter, Telescope, Git integration, and custom keybindings.

## Language Support

The configuration includes comprehensive language support:

- **Nix**: nixd LSP server
- **TypeScript/JavaScript**: typescript-language-server, vscode-langservers-extracted
- **Python**: python3, uv package manager
- **Go**: go, gopls, delve debugger, golangci-lint
- **Rust**: rustup toolchain
- **Solidity**: foundry, slither-analyzer, solc

## Development Tools

Available development tools include:
- **Editors**: neovim (nvf), helix, zed-editor
- **Terminal**: alacritty, ghostty, tmux, zellij
- **Git**: lazygit, standard git
- **File Management**: yazi, fzf
- **Containers**: docker, lazydocker
- **Databases**: postgresql

## Making Changes

1. **System Changes**: Edit `hosts/yoga/configuration.nix` for system-level changes
2. **User Packages**: Edit `hosts/yoga/home.nix` for user applications and shell config
3. **Neovim**: Edit `hosts/shared/nvf.nix` for editor configuration
4. **Flake Updates**: Edit `flake.nix` for input updates or new hosts

All changes require running `bash update.sh yoga` to apply. The script automatically adds changes to git (required for flakes) and rebuilds the system.

## Important Notes

- All files must be tracked in git before rebuilding (flakes requirement)
- The update script requires a hostname argument (`yoga` for this system)
- Hardware configuration is host-specific and rarely needs changes
- nvf provides extensive plugin and language support - check documentation for available options
- Home Manager configuration is integrated directly into the NixOS system configuration