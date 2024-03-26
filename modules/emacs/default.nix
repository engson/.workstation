{pkgs, config, ...}:
{
  # https://bhankas.org/blog/deploying_doom_emacs_config_via_nixos_home_manager/
  programs.emacs = {
    enabled = true;
    package = pkgs.emacs29;
    extraConfig = ''
      (setq user-emacs-directory "~/.config/emacs")
      ;; Set eln-cache dir
      (when (boundp 'native-comp-eln-load-path)
        (startup-redirect-eln-cache (expand-file-name "~/.emacs.d/eln-cache/" user-emacs-directory)))
      '';
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
  home.sessionPath = [
    "${config.xdg.configHome}/emacs/bin"
  ];

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = ["NerdFontsSymbolsOnly"]; })
    ripgrep
    nixfmt
  ];
}
