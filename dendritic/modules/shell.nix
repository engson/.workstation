{...}:{
  flake.nixosModules.shell = {pkgsUnstable, pkgs, ...}:{
    programs.bash = {
      enable = true;
      interactiveShellInit = ''
        # Add bash styling
        eval "$(oh-my-posh init bash --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/probua.minimal.omp.json')"
        # Add devenv hook
        eval "$(devenv hook bash)"
        # Add forge home
        #
        export STEEL_HOME=$HOME/.local/share/steel
      '';
    };
    environment.systemPackages = [
      # Styling
      pkgsUnstable.oh-my-posh
      # dev tools
      pkgsUnstable.devenv
      # nixos diff tool
      pkgs.nvd
      # Languag servers
      pkgs.nil
      pkgs.nixd
    ];
  };
}
