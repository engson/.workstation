
{
  inputs,
  self,
  ...
  
}:
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.modules.nixos.desktop
    ];
  };

  flake.modules.nixos.desktop = {
    # Enable networking
    networking.networkmanager.enable = true;
    networking.hostName = "desktop";
    imports = [
      # Common configs
      self.modules.core
      # User
      self.modules.engson
      # Tools
      self.modules.helix
    ];
  };

}
