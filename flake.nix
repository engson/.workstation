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

  outputs = { nixpkgs, flake-utils, home-manager, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        user = "$USERNAME";
      in {
        defaultPackage.${system} = home-manager.defaultPackage.${system};
        homeConfigurations.engson = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [ ./home.nix ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      });
}