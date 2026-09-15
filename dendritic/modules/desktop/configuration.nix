
{
  inputs,
  self,
  ...
  
}:
{
  flake.modules.nixos.desktop = {
    networking.networkmanager.enable = true;
    networking.hostName = "desktop";
    nixpkgs.hostPlatform = "x86_64-linux";
    import = with inputs.self.modules.nixos; [
      # what to import here?
      #
      core
      
      engson

      helix
    ];
  };

  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
  };
}
