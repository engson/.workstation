let
 username = "engson";
in
{
  flake.modules.nixos."${username}" = {
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
