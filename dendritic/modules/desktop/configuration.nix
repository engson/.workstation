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

  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      # Enable networking
      networking.networkmanager.enable = true;
      networking.hostName = "desktop";
      # Other hardware settings
      hardware.enableAllFirmware = true;

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Use latest kernel.
      boot.kernelPackages = pkgs.linuxPackages_latest;
      boot.kernelParams = [ "amd_iommu=off" ];
      boot.blacklistedKernelModules = [ "nouveau" ];

      # ZSA Keyboard
      hardware.keyboard.zsa.enable = true;

      imports = with self.nixosModules; [
        # Common configs
        core
        fonts
        # User
        engson
        # Tools
        helix

      ];
    };

}
