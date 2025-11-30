{
  inputs,
}:

let
  inherit (inputs)
    nixpkgs
    home-manager
    self
    dotfilesNixos
    ;
  stdenv.hostPlatform.system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${stdenv.hostPlatform.system};
  userName = "aki";
  # flakeRoot is path which flake.nix exists
  flakeRoot = self.outPath;
in
nixpkgs.lib.nixosSystem {
  inherit pkgs;

  modules = [
    {
      imports = [
        (import "${flakeRoot}/nixos/fonts" { inherit pkgs; })
        (import "${flakeRoot}/nixos/sway" { inherit pkgs userName; })
        (import "${flakeRoot}/nixos/sound" { inherit pkgs userName; })
        (import "${flakeRoot}/nixos/gpg" { inherit pkgs userName; })
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
            ];
            home.packages = [
              pkgs.firefox
              pkgs.chromium
              pkgs.wezterm
              pkgs.tree
            ];

            home.file = {
              # sway
              ".config/sway/config" = {
                source = "${dotfilesNixos}/sway/config";
              };
              # waybar
              ".config/waybar" = {
                source = "${dotfilesNixos}/sway/waybar";
                recursive = true;
              };
              # rofi
              ".config/rofi" = {
                source = "${dotfilesNixos}/rofi";
                recursive = true;
              };
              # wlogout
              ".config/wlogout" = {
                source = "${dotfilesNixos}/wlogout";
                recursive = true;
              };
            };
          };
        }
      ];

      # Use the systemd-boot EFI boot loader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.

      networking.hostName = "nixos"; # Define your hostname.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

      # Set your time zone.
      time.timeZone = "Asia/Tokyo";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";
      console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
        useXkbConfig = false; # use xkb.options in tty.
      };

      environment.systemPackages = with pkgs; [
        vim
        wget
        fastfetch
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

      # OpenSSH
      # Enable the OpenSSH daemon.
      services.openssh.enable = true;

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
