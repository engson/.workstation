
{
  inputs,
  self,
  ...
  
}:
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.desktop
    ];
  };

  flake.nixosModules.desktop = {
    # Enable networking
    networking.networkmanager.enable = true;
    networking.hostName = "desktop";


    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    imports = with self.nixosModules; [
      # Common configs
      core
      # User
      engson
      # Tools
      helix
    ];
  };

}
