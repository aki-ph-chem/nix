{
  inputs,
}:

let
  inherit (inputs)
    nixpkgs
    home-manager
    self
    dotfiles
    pgopher
    containerd-shim-wasmtime-v1
    ;
  stdenv.hostPlatform.system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${stdenv.hostPlatform.system};
  userName = "aki";
  # flakeRoot is path which flake.nix exists
  flakeRoot = self.outPath;
  swayConfigBase = builtins.readFile "${dotfiles}/sway/config";
  shellConfigs = {
    envVarShell = "";
    aliases = {
      lock = ''
        swaylock \
        	--screenshots \
        	--clock \
        	--indicator \
        	--indicator-radius 100 \
        	--indicator-thickness 7 \
        	--effect-blur 7x5 \
        	--effect-vignette 0.5:0.5 \
        	--ring-color bb00cc \
        	--key-hl-color 880033 \
        	--line-color 00000000 \
        	--inside-color 00000088 \
        	--separator-color 00000000 \
        	--grace 2 \
        	--fade-in 1'';
    };
  };
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
        (import "${flakeRoot}/nixos/polkit" { inherit pkgs; })
        (import "${flakeRoot}/nixos/gui-app" { inherit pkgs pgopher userName; })
        (import "${flakeRoot}/nixos/nix-ld" { inherit pkgs; })
        (import "${flakeRoot}/nixos/locale" { inherit pkgs; })
        (import "${flakeRoot}/nixos/virtualisation" { inherit pkgs containerd-shim-wasmtime-v1; })
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.users."${userName}" = {
            home.stateVersion = "26.05";
            imports = [
              "${flakeRoot}/modules/neovim.nix"
              "${flakeRoot}/modules/cli-tools.nix"
              "${flakeRoot}/modules/git.nix"
              "${flakeRoot}/modules/i18n.nix"
              "${flakeRoot}/modules/nerd-fonts.nix"
              (import "${flakeRoot}/modules/shell.nix" { inherit pkgs shellConfigs; })
              (import "${flakeRoot}/modules/wezterm.nix" { inherit dotfiles; })
            ];
            home.packages = [
            ];

            home.file = {
              # sway
              ".config/sway/config" = {
                text = ''
                  ${swayConfigBase}

                  # screen shot by flamegraph
                  bindsym Print exec flameshot gui -p $HOME/Pictures/ScreenShot/
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
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.

      networking.hostName = "nixos"; # Define your hostname.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

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
      ];

      # Enable touchpad support (enabled default in most desktopManager).
      # services.libinput.enable = true;

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users."${userName}" = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
          "docker"
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

      # flatpak
      # flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      services.flatpak.enable = true;
      xdg.portal.enable = true;

      system.stateVersion = "25.05"; # Did you read the comment?
    }
  ];
}
