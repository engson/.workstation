{
  description = "Simple tmux wrapper";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nwm.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  outputs = { self, nixpkgs, nwm }:
    let
      system = builtins.currentSystem;
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.default =
        nwm.lib.evalModules {
          inherit pkgs;

          modules = [
            mwn.modules.default
            {
              wrapper.name = "my-tmux";

              wrapper.packages = [ pkgs.tmux ];

              # tmux config injected at runtime
              wrapper.env = {
                TMUX_CONF = pkgs.writeText "tmux.conf" ''
                  set -g mouse on
                  set -g history-limit 10000
                  set -g default-terminal "screen-256color"
                '';
              };

              wrapper.run = ''
                exec tmux -f "$TMUX_CONF"
              '';
            }
          ];
        };

      apps.${system}.default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/my-tmux";
      };
    };
}