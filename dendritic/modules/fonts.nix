{
  flake.nixosModules.fonts = {pkgs, ...}:{
    fonts.fontconfig.enable = true;
    fonts.packages = with pkgs; [
      font-awesome
      font-awesome_6
      iter
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_tff
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      nerd-fonts.hack
    ];
  };
}
