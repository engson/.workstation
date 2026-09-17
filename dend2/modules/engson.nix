let
 username = "engson";
in
{
  flake.nixosModules."${username}" = {
    users.users."${username}" = {
      isNormalUser = true;
      extraGroups = [
        "users"
        "wheel"
        "networkmanager"
      ];
    };
  };
}
