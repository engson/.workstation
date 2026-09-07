{
  flake.nixosModules.core = { pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Enable networking
    networking.networkmanager.enable = true;
    # Set your time zone
    time.timeZone = "Europe/Oslo";
    # Select internationalisentation properties
    i18n.defaultLocale = "en_US.UTF-8";
    
    system.stateVersion = "25.11";
  }; 
}
