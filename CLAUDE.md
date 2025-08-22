# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## NixOS Configuration Overview

This is a NixOS configuration repository using flakes with Home Manager integration. The configuration includes:

- **System**: NixOS with flakes enabled
- **Desktop Environment**: Hyprland (Wayland compositor) with Waybar, Wofi launcher
- **Shell**: Zsh with Oh My Zsh (lambda theme)
- **Editor**: Neovim configured through nix
- **Package Management**: Nix flakes with Home Manager for user packages

All config files (neovim, zellij, hyprland, etc.) are managed through nix. 

## Common Commands

### System Updates and Rebuilds
```bash
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

# Check flake status
nix flake check
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
├── assets/
│   └── hyprland-bg.jpg          # Hyprland background image
└── hosts/
    ├── shared/                   # Shared configurations across hosts
    │   ├── base-home.nix        # Base Home Manager configuration
    │   ├── base-hyprland.nix    # Base Hyprland/Wayland configuration
    │   └── neovim.nix           # Shared Neovim configuration
    ├── desktop/                  # Desktop host configuration
    │   ├── configuration.nix    # Desktop system configuration
    │   ├── hardware-configuration.nix
    │   ├── home.nix
    │   └── hyprland.nix
    ├── lab/                      # Lab host configuration
    │   └── configuration.nix
    └── yoga/                     # Laptop host configuration
        ├── configuration.nix     # System-level NixOS configuration
        ├── hardware-configuration.nix # Hardware-specific settings
        ├── home.nix             # Home Manager user configuration
        └── hyprland.nix         # Host-specific Hyprland settings
```

### Key Components

**Flake Configuration (`flake.nix`)**: Defines inputs (nixpkgs, home-manager, nix-ld) and outputs (nixosConfigurations, homeConfigurations). The yoga configuration integrates Home Manager directly into the NixOS system.

**System Configuration (`hosts/yoga/configuration.nix`)**: NixOS system settings including bootloader, networking, Hyprland window manager, user accounts, and system packages. Enables Docker and VirtualBox virtualization.

**User Configuration (`hosts/yoga/home.nix`)**: Home Manager configuration that imports shared base configurations for home packages and Hyprland setup, plus host-specific Hyprland settings.

**Base Hyprland Configuration (`hosts/shared/base-hyprland.nix`)**: Shared Hyprland/Wayland configuration including window management, keybindings, Waybar status bar with system stats (CPU, memory, temperature), Wofi launcher, and theming. Features fast key repeat, cursor auto-hide, and optimized gaps.

**Neovim Configuration (`hosts/shared/neovim.nix`)**: Neovim configuration with language support for Nix, TypeScript, Rust, Python, Go, and Astro. Features include LSP, Treesitter, Telescope, Git integration, and custom keybindings.

## Making Changes

1. **System Changes**: Edit `hosts/yoga/configuration.nix` for system-level changes
2. **User Packages**: Edit `hosts/shared/base-home.nix` for shared user packages and shell config
3. **Hyprland Configuration**: Edit `hosts/shared/base-hyprland.nix` for window manager, Waybar, and Wayland settings
4. **Host-specific Hyprland**: Edit `hosts/yoga/hyprland.nix` for host-specific Hyprland overrides
5. **Neovim**: Edit `hosts/shared/neovim.nix` for editor configuration
6. **Flake Updates**: Edit `flake.nix` for input updates or new hosts

## Secret Management

The configuration uses environment variables for secrets, loaded from `~/.secrets/.env`. The `.env` file is automatically sourced in the shell initialization. Scripts and aliases reference environment variables directly.

## Important Notes

- All files must be tracked in git before rebuilding (flakes requirement)
- The update script requires a hostname argument (`yoga` for this system)
- Hardware configuration is host-specific and rarely needs changes
- Neovim provides extensive plugin and language support through nix packages
- Home Manager configuration is integrated directly into the NixOS system configuration
- Secrets are stored as environment variables in `~/.secrets/.env`
- Hyprland configuration is split between shared settings (`base-hyprland.nix`) and host-specific overrides
- Waybar includes system monitoring (CPU, memory, temperature) and auto-starts with Hyprland
- Multiple hosts are supported: `yoga` (laptop), `desktop`, and `lab`

## Memory Management

- **Rebuild Directive**: i will rebuild the system myself. do not attempt to rebuild
