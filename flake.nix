{
  description = "My Home Manager flake";

  inputs = {
    # Software source
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # Manages configs and software install by symlinking
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;
 
    homeConfigurations = {
      "engson1" = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux ";
        homeDirectory = "/home/engson1";
        username = "engson1"; 
        configuration.imports = [ ./home.nix ];
      };
    };
  };
}