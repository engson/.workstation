{
  flake.nixosModules.niri =
    {
      pkgs,
      pkgs-unstable,
      ...
    }:
    {
      programs.niri.enable = true;
      environment.systemPackages = [

        # Niri components
        pkgs-unstable.waybar
        pkgs.alacritty
        pkgs.fuzzel
        pkgs.swaylock
        pkgs.playerctl
        pkgs.brightnessctl
        pkgs.wireplumber
        pkgs.swaybg
      ];

      systemd.tmpfiles.rules = [
        "L+ /home/engson/.config/niri - - - - /home/engson/Dev/.workstation/.config/niri"
      ];
    };
}
