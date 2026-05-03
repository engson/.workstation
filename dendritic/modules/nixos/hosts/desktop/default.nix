{ self, inouts
...,
}:
{
  flake.modules.nixos."hosts/desktop" = 
    { lib, pkgs, ... }:
    {
      imports = 
        with config.flake.modules.nixos;
        [
          # Modules
          facter
          shell
          # users
          engson
        ];

        boot = {
          kernelModules = [ "kvm-amd" ];

          initrd.availableKernelModules = [
            "nvme"
            "xhci_pci"
            "ahci"
            "usbhid"
            "usb_storage"
            "sd_mod"
            "sr_mod"
          ];
        };
        facter.reportPath = ./facter.json;

        fileSystems."/" ={ 
          device = "/dev/disk/by-uuid/c6147d9c-9fa9-43eb-abe5-0f2dbf027176";
          fsType = "ext4";
        };

        fileSystems."/boot" = { 
          device = "/dev/disk/by-uuid/D1C7-57EA";
          fsType = "vfat";
          options = [ "fmask=0077" "dmask=0077" ];
        };

      swapDevices = [
        { device = "/dev/disk/by-uuid/131e3c44-92ed-4ef2-a659-4f1dd086b6e5"; }
      ];
    };
}