{pkgs,config,...}:
{
  home.file.bashrc = {
    enable = true;
    executable = true;
    recursive = false;
    source = ./.bashrc;
    target = "${config.xdg.configHome}/.bashrc";
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

      if [ -f $XDG_CONFIG_HOME/.bashrc ]; then
        source $XDG_CONFIG_HOME/.bashrc
      fi
    '';
    profileExtra =
      ''export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"'';
  };
}
