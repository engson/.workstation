{
  flake.modules.nixos.desktop = {
    services.xserver.videoDriver = [ "nvidia" ];
    hardware.nvidia = { 
      branch = "legacy_580";
      modesetting.enable = true;
      open = false;
      powerManagement.enable = false;
      nvidiaSettings = true;
    };
    hardware.graphics.enable = true;
  };
}
