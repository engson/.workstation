
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


    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    imports = with self.modules.nixos; [
      # Common configs
      core
      # User
      engson
      # Tools
      helix
    ];
  };

}
