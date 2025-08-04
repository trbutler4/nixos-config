{
  description = "NixOS configuration for multiple hosts";

  inputs = {
    nixpkgs.follows = "nixos-cosmic/nixpkgs";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      nixos-cosmic,
      home-manager,
      nvf,
      ...
    }@inputs:
    {
      homeConfigurations = {
        trbiv = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
            }
          ];
        };
      };

      nixosConfigurations = {

        # Configuration for lenovo yoga laptop
        yoga = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              };
            }
            nixos-cosmic.nixosModules.default
            ./hosts/yoga/configuration.nix
            home-manager.nixosModules.default
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.trbiv = import ./hosts/yoga/home.nix;
            }
          ];
        };

        # Configuration for desktop
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/desktop/configuration.nix
            home-manager.nixosModules.default
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.trbiv = import ./hosts/desktop/home.nix;
              home-manager.users.guest = import ./hosts/desktop/guest-home.nix;
            }
          ];
        };

        # Configuration for desktop with COSMIC
        desktop-cosmic = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              };
            }
            nixos-cosmic.nixosModules.default
            ./hosts/desktop-cosmic/configuration.nix
            home-manager.nixosModules.default
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.trbiv = import ./hosts/desktop-cosmic/home.nix;
              home-manager.users.guest = import ./hosts/desktop/guest-home.nix;
            }
          ];
        };

        # Configuration for lab home server
        lab = nixpkgs-stable.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/lab/configuration.nix
          ];
        };

      };

    };
}
