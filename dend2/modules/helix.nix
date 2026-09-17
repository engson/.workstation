{
  flake.nixosModules.helix = {
    pkgs, ...}:
    {
    environment.systemPackages = [
      pkgs.steelix
      pkgs.steel
    ];

    systemd.tmpfiles.rules = [
      "L+ /home/engson/.config/helix - - - - /home/engson/Dev/.workstation/.config/helix"
    ];
  };
}
