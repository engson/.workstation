{

  description = "My systems configuration, using NixOS + Home-manager";

  # Declares flake inputs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/25.11";
    # Allow creating modular, composable and reusable flakes
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    # Allow recursivly importing .nix file (modules)
    import-tree.url = "github:vic/import-tree";
    # Allow wrapping packages into self-contained derivatives.
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
