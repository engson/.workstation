{
  inputs,
  ...
}:
let
  username = "engson";
in
{
  flake.modules.homeManager."${username}" = 
    {pkgs, ...}:
    {
      imports = with inputs.self.modules.homeManager; [
        system-cli
        #
      ];
      home.username = "${username}";
      home.packages = with pkgs; [
        nh # wrapper for nixos and hm
        cowsay
        fastfetch
        just
        fd
        shellcheck
        which
        bat

        btop
        pandoc
        asciidoctor

        nixfmt
        # work related packages
        bitwarden-desktop
      ]
    }
}