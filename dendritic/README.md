# Basic dendritic

```yaml

Yes — those changes fit the dendritic pattern well. I’d make the structure more explicit around the desktop host, while keeping reusable system/program aspects at the top level.

I’d also treat each dotfile as an aspect in its own right, so enabling the helix aspect means both “install Helix” and “make the Helix configuration available.”

Revised tree

I’d rename basic/ → dendritic/ and use:

dendritic/
├── flake.nix
├── flake.lock
└── modules/
    ├── hosts/
    │   └── desktop/
    │       ├── configuration.nix
    │       ├── flake-parts.nix
    │       ├── hardware.nix
    │       │
    │       ├── users/
    │       │   ├── engson.nix
    │       │   └── vm.nix
    │       │
    │       └── dotfiles/
    │           ├── helix.nix
    │           ├── niri.nix
    │           ├── tmux.nix
    │           ├── waybar.nix
    │           └── zed.nix
    │
    ├── programs/
    │   ├── firefox.nix
    │   ├── niri.nix
    │   ├── shell.nix
    │   └── terminal.nix
    │
    ├── services/
    │   ├── audio.nix
    │   ├── desktop.nix
    │   └── printing.nix
    │
    └── system/
        ├── boot.nix
        ├── fonts.nix
        ├── networking.nix
        ├── nix.nix
        ├── nvidia.nix
        └── zsa.nix


There are two subtle advantages here.

First, users really are host-specific in your current setup, so putting them under hosts/desktop/users makes sense.

Second, dotfiles are now first-class aspects:

hosts/desktop/dotfiles/helix.nix


rather than one miscellaneous dotfiles.nix.

Host composition

I'd consequently make configuration.nix the place where the desktop gets assembled:

{
  inputs,
  ...
}:

{
  flake.modules.nixos.desktop = {
    imports = with inputs.self.modules.nixos; [
      # Host
      desktop-hardware

      # System
      boot
      networking
      nvidia
      nix
      fonts
      zsa

      # Desktop
      desktop
      audio
      printing

      # Programs
      firefox
      shell
      terminal
      niri

      # Users
      desktop-engson
      desktop-vm

      # Dotfiles
      desktop-dotfile-helix
      desktop-dotfile-niri
      desktop-dotfile-tmux
      desktop-dotfile-waybar
      desktop-dotfile-zed
    ];
  };
}


This makes the host configuration quite readable: it's essentially a manifest of what constitutes your desktop.

Dotfiles

This is the part I particularly like about your proposed change.

Instead of:

systemd.tmpfiles.rules = [
  "L+ /home/engson/.config/helix ... "
  "L+ /home/engson/.config/niri ... "
  ...
];


each configuration gets its own aspect.

For example:

modules/hosts/desktop/dotfiles/helix.nix
{
  flake.modules.nixos.desktop-dotfile-helix =
    { ... }:
    {
      systemd.tmpfiles.rules = [
        "L+ /home/engson/.config/helix - - - - /home/engson/Dev/.workstation/.config/helix"
      ];
    };
}


But I'd go one step further.

If "install and link the corresponding dotfile" is the intended responsibility of the aspect, I'd have it install the relevant application too.

So:

{
  flake.modules.nixos.desktop-dotfile-helix =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.helix
      ];

      systemd.tmpfiles.rules = [
        "L+ /home/engson/.config/helix - - - - /home/engson/Dev/.workstation/.config/helix"
      ];
    };
}


Now this:

desktop-dotfile-helix


means:

"This machine uses my Helix setup."

rather than merely:

"Create a symlink."

That is much closer to an aspect-oriented design.

Niri

modules/hosts/desktop/dotfiles/niri.nix:

{
  flake.modules.nixos.desktop-dotfile-niri =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.niri
      ];

      systemd.tmpfiles.rules = [
        "L+ /home/engson/.config/niri - - - - /home/engson/Dev/.workstation/.config/niri"
      ];
    };
}


There's one architectural question here, though.

You already have:

modules/programs/niri.nix


which enables:

programs.niri.enable = true;


So I would actually not install niri again in the dotfile aspect.

Instead:

{
  flake.modules.nixos.desktop-dotfile-niri = {
    systemd.tmpfiles.rules = [
      "L+ /home/engson/.config/niri - - - - /home/engson/Dev/.workstation/.config/niri"
    ];
  };
}


The separation becomes:

programs/niri.nix
    └── enable Niri

hosts/desktop/dotfiles/niri.nix
    └── configure Niri


That's cleaner.

The same principle applies to Helix, tmux, Zed, etc.:

program
  └── install/enable program

dotfile
  └── configure program


If we later discover that one of these applications has a better Nix-native configuration mechanism, we can migrate the configuration there without changing the host composition.

Zed
{
  flake.modules.nixos.desktop-dotfile-zed = {
    systemd.tmpfiles.rules = [
      "L+ /home/engson/.config/zed - - - - /home/engson/Dev/.workstation/.config/zed"
    ];
  };
}

Tmux
{
  flake.modules.nixos.desktop-dotfile-tmux = {
    systemd.tmpfiles.rules = [
      "L+ /home/engson/.config/tmux - - - - /home/engson/Dev/.workstation/.config/tmux"
    ];
  };
}

Waybar
{
  flake.modules.nixos.desktop-dotfile-waybar = {
    systemd.tmpfiles.rules = [
      "L+ /home/engson/.config/waybar - - - - /home/engson/Dev/.workstation/.config/waybar"
    ];
  };
}

Helix
{
  flake.modules.nixos.desktop-dotfile-helix = {
    systemd.tmpfiles.rules = [
      "L+ /home/engson/.config/helix - - - - /home/engson/Dev/.workstation/.config/helix"
    ];
  };
}

Users

I'd definitely move these to:

modules/
└── hosts/
    └── desktop/
        └── users/
            ├── engson.nix
            └── vm.nix

engson.nix
{
  flake.modules.nixos.desktop-engson = {
    users.users.engson = {
      isNormalUser = true;

      description = "sondre engen";

      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}

vm.nix
{
  flake.modules.nixos.desktop-vm = {
    users.groups.vm = { };

    users.users.vm = {
      isNormalUser = true;
      group = "vm";
    };
  };
}


Again, I would leave the plaintext initialPassword = "test" out of the migrated version.

One naming convention I'd recommend

Since these are host-local aspects, I'd consistently prefix their names:

desktop-hardware
desktop-engson
desktop-vm

desktop-dotfile-helix
desktop-dotfile-niri
desktop-dotfile-tmux
desktop-dotfile-waybar
desktop-dotfile-zed


Whereas genuinely reusable aspects remain unprefixed:

boot
nvidia
networking
audio
printing
firefox
niri
shell
terminal
fonts
zsa


That gives you a useful visual distinction:

imports = with inputs.self.modules.nixos; [
  # Reusable aspects
  boot
  nvidia
  networking
  audio
  niri

  # Desktop-specific aspects
  desktop-hardware
  desktop-engson
  desktop-vm

  desktop-dotfile-helix
  desktop-dotfile-niri
  desktop-dotfile-tmux
  desktop-dotfile-waybar
  desktop-dotfile-zed
];

One further improvement I'd make

I'd change the dotfile paths so they don't hard-code /home/engson.

For example, each aspect can use:

{
  flake.modules.nixos.desktop-dotfile-helix =
    { config, ... }:
    {
      systemd.tmpfiles.rules = [
        "L+ ${config.users.users.engson.home}/.config/helix - - - - /home/engson/Dev/.workstation/.config/helix"
      ];
    };
}


Even better, we could make the repository location configurable, so the aspects don't know that the checkout happens to be at /home/engson/Dev/.workstation.

That would give us a much nicer eventual design:

desktop
│
├── hardware
├── users
│   ├── engson
│   └── vm
│
├── system
│   ├── boot
│   ├── nvidia
│   └── networking
│
├── desktop
│   ├── plasma
│   ├── niri
│   └── audio
│
└── dotfiles
    ├── helix
    ├── niri
    ├── tmux
    ├── waybar
    └── zed


with the host aspect acting as the composition root.

That's the structure I'd use going forward. It keeps the changes you requested—dendritic/, host-local users, and one aspect per dotfile—without turning the repository into an unnecessarily deep maze of modules.
```
