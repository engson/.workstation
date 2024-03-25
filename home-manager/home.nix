{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    # ../home/engson/features/ripgrep
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # home.username = "${username}";
  # home.homeDirectory = "/home/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  # home.stateVersion = "23.05"; # Please read the comment before changing.

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

    # Devenv packages
    #pkgs.cachix
    #inputs.devenv.packages."${pkgs.system}".devenv

    # Doome emacs stuffs
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    # pkgs.emacs29
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

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
    # Doom emacs
    # https://bhankas.org/blog/deploying_doom_emacs_config_via_nixos_home_manager/
    doom = {
      enable = true;
      executable = false;
      recursive = true;
      source = ../configs/doom;
      target = "${config.xdg.configHome}/doom";
    };

    bashrc = {
      enable = true;
      executable = true;
      recursive = false;
      source = ../configs/.bashrc;
      target = "${config.xdg.configHome}/.bashrc";
    };
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
    DOOMDIR = "${config.xdg.configHome}/doom";
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
      userName = "Sondre Engen";
      userEmail = "corastweb94@hotmail.com";

      aliases = {
        s = "status";
        commit = "commit -s";
      };
    };

    bash = {
      enable = true;
      initExtra = ''
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

        if [ -f $XDG_CONFIG_HOME/.bashrc ]; then
          source $XDG_CONFIG_HOME/.bashrc
        fi

        export PATH=$XDG_CONFIG_HOME/emacs/bin:$PATH
      '';
      profileExtra =
        ''export XDG_DATA_DIRS="$HOME/.nix-profile/share:$XDG_DATA_DIRS"'';
    };

  };
}
