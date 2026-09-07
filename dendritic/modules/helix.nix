{
  flake.modules.nixos.helix = {
    pkgs, ...}:
    {
    environment.systemPackages = [
      pkgs.helix
    ];

    systemd.tmpfiles.rules = [
      "L+ /home/engson/.config/helix - - - - /home/engson/Dev/.workstation/.config/helix"
    ];
  };
}
