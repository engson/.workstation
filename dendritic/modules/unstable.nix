# /dendritic/modules/unstable.nix
{ inputs, ... }: {
  # This registers a global NixOS module that all your machines will inherit
  flake.nixosModules.unstable = { pkgs, ... }: {
    _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
      inherit (pkgs) system;
      config = { allowUnfree = true; };
    };
  };
}
