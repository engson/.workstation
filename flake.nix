{
  description = "My NixOS + Home-manager configuration";

  inputs = {
    # Software source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    # All linux systems
    systems.url = "github:nix-systems/default-linux";
    # Manages configs and software install by symlinking
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, systems, ... } @ inputs: let
    inherit (self) outputs;
    # Merge into one lib, prioritizing home manager
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = fun: lib.genAttrs (import systems) (system: fun pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
    username = "engson";
  in {
    inherit lib;
      # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    # Accessible through 'nix develop'
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    # Formatter for your nix files, available through 'nix fmt'
    formatter = forEachSystem (pkgs: pkgs.alejandra);

    nixosConfigurations = {
      # Main desktop
      desktop = lib.nixosSystem {
        modules = [./hosts/desktop];
        specialArgs = {
          inherit inputs outputs;
        };
      };
      # Laptop
      laptop = nix.nixosSystem {
        modules = [./hosts/laptop];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # Work laptop with fedora
      "${username}@work" = lib.homeManagerConfiguration {
        modules = [ ./home/${username}/work.nix ./home/${username}/nixpkgs.nix ];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}
