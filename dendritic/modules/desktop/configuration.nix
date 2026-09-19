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

      # Desktop environment
      services.displayManager.sddm.enable = true;
      services.displayManager.sddm.wayland.enable = true;

      environment.systemPackages = [
        # ZSA gui
        pkgs.keymapp
      ];
      # Browser
      programs.firefox.enable = true;
      # Security
      security.sudo.extraConfig = ''
        Defaults timestamp_timeout=30
      '';

      imports = with self.nixosModules; [
        # Common configs
        unstable
        core
        fonts
        # User
        engson
        # GUI
        niri

        # Tools
        shell
        helix
        tmux
        git

      ];
    };

}
