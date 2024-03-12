{
  description = "My Home Manager flake";

  inputs = {
    # Software source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Flake util functions
    flake-utils.url = "github:numtide/flake-utils";
    # Manages configs and software install by symlinking
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Devenv for easy setup of development environments
    devenv.url = "github:cachix/devenv/latest";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;
      systems = [
        "x86_86-linux"
      ];
      username = "engson";
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      # Your custom packages
      # Accessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      # Formatter for your nix files, available through 'nix fmt'
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays {inherit inputs;};

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "${username}@desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        # Specify your home configuration modules here, for example,
        extraSpecialArgs = {inherit inputs outputs;};

        # the path to your home.nix.
        modules = [
          {
            home = {
              username = "${username}";
              homeDirectory = "/home/${username}";
              stateVersion = "23.11";
            };
          }
          ./home-manager/home.nix 
        ];
      };
      "${username}@work" = home-manager.lib.homeMamangerConfiguration {
        pkgs = nixpkgs.legacyPacakges.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          {
            home = {
              username = "${username}";
              homeDirectory = "/home/${username}";
              stateVersion = "23.11";
            };
          }
          ./home-manager/home.nix
        ];
      };
    };
  };
}
