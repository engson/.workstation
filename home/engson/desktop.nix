{ pkgs, inputs, outputs, lib, config, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./features/ripgrep
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.cowsay
    pkgs.neofetch
    #pkgs.hello
    pkgs.just
    pkgs.fd
    pkgs.shellcheck
    pkgs.which
    pkgs.bat

    pkgs.gh

    pkgs.btop
    pkgs.pandoc
    pkgs.asciidoctor

    pkgs.nixfmt
    # Work related packages

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  home.stateVersion = "25.11";
  home.username = "engson";
  home.homeDirectory = "/home/engson";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # home.activation.doom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   if [ -x "${config.xdg.configHome}/emacs/bin/doom" ]; then
  #     env
  #     pwd
  #     "${pkgs.which}/bin/which" emacs
  #     "${config.xdg.configHome}/emacs/bin/doom" sync
  #   fi
  #   '';

  fonts.fontconfig.enable = true;

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/engson/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # NOTE! Only reloads on login
    # EDITOR = "emacs";
  };

  xdg = {
    enable = true;
    mime.enable = true;
  };

  targets.genericLinux.enable = true;

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    tmux = {
      enable = true;
      historyLimit = 20000;
      terminal = "tmux-256color";
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
    };

    git = {
      enable = true;
      settings = {
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

    bash = {
      enable = true;
    };

  };
}
