{ ... }:
{
  flake.nixosModules.niri =
    {
      pkgs,
      pkgsUnstable,
      ...
    }:
    {
      programs.niri.enable = true;
      environment.systemPackages = [

        # Niri components
        pkgsUnstable.waybar
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
        "L+ /home/engson/.config/waybar - - - - /home/engson/Dev/.workstation/.config/waybar"
      ];
    };
}
