{
  description = "My Home Manager flake";

  inputs = {
    # Software source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Flake util functions
    flake-utils.url = "github:numtide/flake-utils";
    # Manages configs and software install by symlinking
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      username = "engson";
    in {
      defaultPackage.${system} = home-manager.defaultPackage.${system};
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
          {
            home = {
              username = "${username}";
              homeDirectory = "/home/${username}";
              stateVersion = "23.05";
            };
          }
          ./home.nix 
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}