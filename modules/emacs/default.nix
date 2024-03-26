{pkgs, config, ...}:
{
  programs.emacs = {
    enabled = true;
    package = pkgs.emacs;
  };

  home.sessionVaribles = {
    DOOMDIR = "${config.xdg.configHome}/doom";
  };

  home.file = {
    doom = {
      enabled = true;
      executable = false;
      recursive = false;
      source = ./doom;
      target = "${config.xdg.configHome}/doom";
    };
  };
  home.packages = [
    (pkgs.nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })
  ];
}
