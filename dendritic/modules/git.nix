{
  flake.nixosModules.git = {pkgs, ...}:{
    programs.git = {
      enable = true;
      config = {
        user = {
          email = "corastweb94@hotmail.com";
          name = "Sondre Engen";
        };
        alias = {
          s = "status";
          commit = "commit -s";
        };
      };
    };
    environment.systemPackages = [
      pkgs.git
    ];
  };
}
