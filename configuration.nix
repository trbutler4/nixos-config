# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
	imports = [
  		<nixos-wsl/modules>
  		# Instead of the direct import, use the recommended way:
  		"${builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz"}/nixos"
	];
	
	system.stateVersion = "24.11"; 

	wsl.enable = true;
	wsl.defaultUser = "iv";

	nix.settings.experimental-features = [
		"nix-command" 
		"flakes"
	];

	users.users.iv = {
		isNormalUser = true; 
		extraGroups = [ "wheel" ]; # for sudo access
	};


	home-manager.users.iv = { config, lib, pkgs, ... }: {
		home.stateVersion = "24.11"; 

		home.packages = with pkgs; [ 
			# essential
			gcc
			git
			tmux
			vim

			# tools
			zellij
			lazygit
			htop
			btop
			bat
			yazi
			fzf
			evil-helix

			# language support
			go
			gopls
			python314

		    	# Language servers
		    	pyright
		    	rust-analyzer
		    	gopls
		    	nodePackages.typescript-language-server

			# misc
			fastfetch
			cmatrix
		];
		
		programs.bash.enable = true;
		programs.fish.enable = true;


		  programs.tmux = {
		    enable = true;
		    shortcut = "Space";  
		    terminal = "tmux-256color";
		    keyMode = "vi";      
		    extraConfig = ''
		      # ===== Basic Settings =====
			set -g default-terminal "tmux-256color"  # Better color support
			set -g escape-time 10                    # Faster escape sequence detection
			set -g base-index 1                      # Start window numbering at 1
			set -g pane-base-index 1                 # Start pane numbering at 1
			set -g renumber-windows on               # Renumber windows when one is closed
			set -g mouse on                          # Enable mouse support (scroll, resize, click)

			# ===== Key Bindings =====
			# Prefix: Ctrl-Space (instead of default Ctrl-b)
			set -g prefix C-Space
			unbind C-b
			bind C-Space send-prefix

			# Split panes with | (vertical) and - (horizontal)
			bind | split-window -h -c "#{pane_current_path}"
			bind - split-window -v -c "#{pane_current_path}"
			unbind '"'
			unbind %

			# Reload config (r)
			bind r source-file ~/.tmux.conf \; display "Reloaded config!"

			# Easy window navigation (Alt-arrow)
			bind -n M-Left select-pane -L
			bind -n M-Right select-pane -R
			bind -n M-Up select-pane -U
			bind -n M-Down select-pane -D

			# ===== Status Bar =====
			set -g status-style "fg=white,bg=black"  # Clean colors
			set -g status-left "#[bold]#S #[default]" # Show session name
			set -g status-right "#(date '+%H:%M')"   # Time on the right
			set -g status-interval 1                 # Update every second

			# Window list in status bar
			set -g window-status-format "#I:#W"      # Simple format: index:name
			set -g window-status-current-format "#[reverse]#I:#W" # Highlight current

			# ===== Misc =====
			set -g history-limit 5000                # Increase scrollback buffer

		    '';
		  };


		programs.neovim = {
			enable = true;
			viAlias = true;
			vimAlias = true;
			vimdiffAlias = true;
			    
			plugins = with pkgs.vimPlugins; [
				# Essential plugins
			      	plenary-nvim
			      	nvim-web-devicons
			      	nvim-treesitter.withAllGrammars
			      	nvim-lspconfig
			      	nvim-cmp
			      	cmp-nvim-lsp
			      	lspkind-nvim
			      	luasnip
			      	cmp_luasnip
			      	telescope-nvim
			      
				# UI/UX plugins
				vim-commentary
				vim-surround
				vim-sleuth  # Automatic indentation detection
				vim-fugitive
				vim-gitgutter 

				# Colorscheme
				nord-nvim  
				tokyonight-nvim
			    ];
			    
			extraLuaConfig = ''
			      -- Basic settings
			      vim.opt.number = true
			      vim.opt.relativenumber = true
			      vim.opt.tabstop = 4
			      vim.opt.shiftwidth = 4
			      vim.opt.expandtab = true
			      vim.opt.smartindent = true
			      vim.opt.termguicolors = true
			      vim.opt.mouse = "a"
			      vim.opt.clipboard = "unnamedplus"
			      
			      -- Enable transparency
			      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

			      -- Load Tokyo Night with transparency
			      require("tokyonight").setup({
				style = "night",  -- other options: storm, night, moon, day
				transparent = true,
				styles = {
				  sidebars = "transparent",
				  floats = "transparent",
				}
			      })
			      vim.cmd("colorscheme tokyonight")
			    '';
		};
      };
}
