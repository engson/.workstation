{
  flake.nixosModules.helix = {
    pkgs-unstable, ...}:
    {
    environment.systemPackages = [
      pkgs-unstable.steelix
      pkgs-unstable.steel
    ];

    systemd.tmpfiles.rules = [
      "L+ /home/engson/.config/helix - - - - /home/engson/Dev/.workstation/.config/helix"
    ];
  };
}
