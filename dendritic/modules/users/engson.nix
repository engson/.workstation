{ inputs, self, ...}:
let
  username = "engson";
in
{
  flake.modules.nixos."${username}" =
  {
    lib,
    config,
    pkgs,
    ...
  }:
  {
    import = with inputs.self.modules.nixos; [
      # developmentEnvironment
    ];

    users.users."${username}" = {
      isNormalUser = true;
      description = "sondre engen";
      extraGrups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
