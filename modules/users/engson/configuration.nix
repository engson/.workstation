{
  input,
  self,
  ...
}:
let
  username = "engson";
in
{
  flake.module.nixos."${username}" = 
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      imports = with inputs.self.modules.nixos; [
        # Dev environment
      ];
      home-manager.users."${username}" = {
        imports = [
          inputs.self.module.homeManager."${username}"
        ];
      };

      users.users."${username}" = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
      }
    
    
    
    
    };
}