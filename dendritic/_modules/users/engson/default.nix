topLevel@{
  input,
  ...
}:
{
  flake = {
    meta.users = {
      engson = {
        email = "corastweb94@hotmail.com";
        name = "Sondre Engen";
        username = "engson";
      };
    };

    modules.nixos.engson = {
      users.users.engson = {
        description = topLevel.config.flake.meta.users.engson.name;
        isNormalUser = true;
        extraGroups = [ 
          "audio"
          "sound"
          "networkmanager"
          "wheel"
        ];
      };
    };

    modules.homeManager.engson = {
      home.file = {

      };
    };
  };
}
