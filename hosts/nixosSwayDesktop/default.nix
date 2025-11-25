{
  inputs,
}:

let
  inherit (inputs)
    nixpkgs
    home-manager
    self
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
            ];
            home.packages = [
              pkgs.firefox
              pkgs.chromium
              pkgs.wezterm
              pkgs.tree
              ## sway-related
              pkgs.waybar
              pkgs.rofi
            ];
          };
        }
      ]
      ++ [
        (import "${flakeRoot}/nixos/fonts" { inherit pkgs; })
      ];

      # Use the systemd-boot EFI boot loader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Use latest kernel.
      boot.kernelPackages = pkgs.linuxPackages_latest;

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
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        wget
        fastfetch
      ];

      # Enable sound.
      # services.pulseaudio.enable = true;
      # use pipewire
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

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
          ## sway-related
          swayidle
          swaybg
          swaylock-effects
          xwayland
          ## other
          brightnessctl
          clipman
          gnupg
          helvum
          pavucontrol
        ];
      };
      # uninstall nano
      programs.nano.enable = false;

      programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
      };

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

      # for smart card like Yubikey
      services.pcscd.enable = true;
      programs.gnupg.agent = {
        enable = true;
        enableExtraSocket = true;
      };

      system.stateVersion = "25.05"; # Did you read the comment?
    }
  ];
}
