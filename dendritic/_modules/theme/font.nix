{
  flake.modules.nixos.desktop = 
    {
      pkgs, ...
    }:
    {
      fonts.fontconfig.enable = true;
    }
}