{
  inputs,
}:

let
  inherit (inputs)
    nixpkgs
    lanzaboote
    home-manager
    self
    dotfiles
    ;
  stdenv.hostPlatform.system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${stdenv.hostPlatform.system};
  userName = "aki";
  # flakeRoot is path which flake.nix exists
  flakeRoot = self.outPath;
  swayConfigBase = builtins.readFile "${dotfiles}/sway/config";
in
nixpkgs.lib.nixosSystem {
  inherit pkgs;

  modules = [
    lanzaboote.nixosModules.lanzaboote
    (
      { pkgs, lib, ... }:
      {
        boot.loader.systemd-boot.enable = lib.mkForce false;

        boot.lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
        };
      }
    )
    {
      imports = [
        (import "${flakeRoot}/nixos/fonts" { inherit pkgs; })
        (import "${flakeRoot}/nixos/sway" { inherit pkgs userName; })
        (import "${flakeRoot}/nixos/sound" { inherit pkgs userName; })
        (import "${flakeRoot}/nixos/gpg" { inherit pkgs userName; })
        (import "${flakeRoot}/nixos/polkit" { inherit pkgs; })
        (import "${flakeRoot}/nixos/gui-app" { inherit pkgs userName; })
        (import "${flakeRoot}/nixos/nix-ld" { inherit pkgs; })
        (import "${flakeRoot}/nixos/locale" { inherit pkgs; })
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.users."${userName}" = {
            home.stateVersion = "25.05";
            imports = [
              "${flakeRoot}/modules/neovim.nix"
              "${flakeRoot}/modules/cli-tools.nix"
              "${flakeRoot}/modules/git.nix"
              "${flakeRoot}/modules/i18n.nix"
              "${flakeRoot}/modules/nerd-fonts.nix"
              "${flakeRoot}/modules/shell.nix"
              (import "${flakeRoot}/modules/wezterm.nix" { inherit dotfiles; })
              "${flakeRoot}/modules/latex.nix"
            ];
            home.packages = [
            ];

            home.file = {
              # sway
              ".config/sway/config" = {
                text = ''
                  ${swayConfigBase}
                  # give Sway a little time to startup before starting kanshi.
                  exec sleep 5; systemctl --user start kanshi.service
                '';
              };
              # waybar
              ".config/waybar" = {
                source = "${dotfiles}/sway/waybar";
                recursive = true;
              };
              # rofi
              ".config/rofi" = {
                source = "${dotfiles}/rofi";
                recursive = true;
              };
              # kanshi
              ".config/kanshi" = {
                source = "${dotfiles}/sway/kanshi";
                recursive = true;
              };
              # wlogout
              ".config/wlogout" = {
                source = "${dotfiles}/wlogout";
                recursive = true;
              };
            };
          };
        }
      ];

      # Use the systemd-boot EFI boot loader.
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.

      # Swap file
      swapDevices = [
        {
          device = "/var/lib/swapfile";
          size = 32 * 1024; # 32 GB
        }
      ];

      networking.hostName = "nix"; # Define your hostname.
      networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
      networking.networkmanager.wifi.backend = "iwd"; # Enables wireless support via iwd.
      # config for iwd
      networking.wireless.iwd.settings = {
        Network = {
          EnableIPv6 = true;
        };
        Settings = {
          AutoConnect = true;
        };
      };
      # firewall: deny all in-comming
      networking.firewall.enable = true;
      # enable bluetooth
      hardware.bluetooth.enable = true;

      # OpenSSH
      # Enable the OpenSSH daemon.
      services.openssh.enable = true;

      # Set your time zone.
      time.timeZone = "Asia/Tokyo";

      console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
        useXkbConfig = false; # use xkb.options in tty.
      };

      environment.systemPackages = with pkgs; [
        vim
        wget
        fastfetch
        tree
        htop
        # For debugging and troubleshooting Secure Boot.
        sbctl
      ];

      # Enable touchpad support (enabled default in most desktopManager).
      # services.libinput.enable = true;

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users."${userName}" = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
        ]; # Enable ‘sudo’ for the user.
        packages = with pkgs; [
        ];
      };
      # uninstall nano
      programs.nano.enable = false;

      environment.sessionVariables = {
        EDITOR = "nvim";
      };

      # make flakes and nix-command active
      nix = {
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      };

      # Docker
      virtualisation = {
        docker = {
          enable = true;
        };
      };

      # flatpak
      services.flatpak.enable = true;
      xdg.portal.enable = true;

      system.stateVersion = "25.05"; # Did you read the comment?
    }
  ];
}
