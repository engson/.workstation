{
  flake.modules.nixos.helix = {
    pkgs-unstable, ...}:
    {
    environment.systemPackages = [
      pkgs-unstable.steelix
      pkgs-unstable.forge
    ];

    systemd.tmpfiles.rules = [
      "L+ /home/engson/.config/helix - - - - /home/engson/Dev/.workstation/.config/helix"
    ];
  };
}
